import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/manager_section/model/ManagerListModel.dart';
import 'package:tc_mcandy/features/celebrity%20side/manager_section/presentration/widget/custom_popup.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/helpers_method.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController managerController = TextEditingController();

  bool isActive = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkFields);
    managerController.addListener(_checkFields);
    _fetchManagers();
  }

  void _fetchManagers() async {
    await getManagerListRxObj.fetch();
  }

  void _checkFields() {
    setState(() {
      isActive =
          emailController.text.isNotEmpty && managerController.text.isNotEmpty;
    });
  }

  void _sendInvitation() async {
    if (!isActive) return;

    try {
      setState(() {
        isLoading = true;
      });
      bool success = await postSendInvitationRx.post(
        name: managerController.text.trim(),
        email: emailController.text.trim(),
      );

      if (success) {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return CustomPopup(
                title: "Invitation successful",
                message:
                    "Your invitation is submitted successfully. The manager will be able to manage you profile after accepting the invitation.",
              );
            },
          );
          managerController.clear();
          emailController.clear();
          _fetchManagers();
        }
      }
    } catch (e) {
      customToastMessage("Warning", e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteManager(int managerId) async {
    bool success = await postDeleteManagerRxObj.post(managerId: managerId);
    if (success) {
      customToastMessage("Success", "Manager removed successfully");
      _fetchManagers();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isActive =
        emailController.text.isNotEmpty && managerController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppBar(title: "Manager Settings", showFilter: false),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    border: Border.all(
                      color: AppColors.c7C7C7C.withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "This settings for introduce your manager with your profile. So that they can manage all the necessary works for you.",
                    style: TextFontStyle.headline14w400cADADADurbanist,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CustomFormField(
                  controller: managerController,
                  hintText: "Manager name",
                  prefixIcon: SvgPicture.asset(Assets.icons.person),
                ),
                UIHelper.verticalSpace(16.h),
                CustomFormField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: SvgPicture.asset(Assets.icons.emailIcon),
                ),
                UIHelper.verticalSpace(40.h),
                CustomButton(
                  onTap: _sendInvitation,
                  btnName: "Send Invitation",
                  isGradient: true,
                  isActive: isActive,
                  isLoading: isLoading,
                ),
                UIHelper.verticalSpace(40.h),
                Text(
                  "Managers",
                  style: TextFontStyle.headline16w400c303030urbanist.copyWith(
                    color: AppColors.c7C7C7C,
                  ),
                ),
                UIHelper.verticalSpace(12.h),

                Expanded(
                  child: Stack(
                    children: [
                      /// ListView
                      StreamBuilder(
                        stream: getManagerListRxObj.fillData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Failed to load managers. Please try again.",
                                  ),
                                ],
                              ),
                            );
                          }

                          final ManagerListModel? model = snapshot.data;
                          final managers = model?.data ?? [];

                          if (managers.isEmpty) {
                            return Center(
                              child: Text(
                                "No managers found",
                                style:
                                    TextFontStyle.headline16w500c7C7C7Curbanist,
                              ),
                            );
                          }

                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: managers.length,
                            separatorBuilder: (context, index) =>
                                UIHelper.verticalSpace(12.h),
                            itemBuilder: (context, index) {
                              final manager = managers[index];
                              return Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: AppColors.cFFFFFF,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: AppColors.cADADAD.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            manager.name ?? "N/A",
                                            style: TextFontStyle
                                                .headline16w400c303030urbanist,
                                          ),
                                          UIHelper.verticalSpace(4.h),
                                          Text(
                                            manager.email ?? "N/A",
                                            style: TextFontStyle
                                                .headline16w400c303030urbanist
                                                .copyWith(
                                                  color: AppColors.c7C7C7C,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCustomDialog(
                                          context: context,
                                          titile: 'Cancel',
                                          subTitile:
                                              'Are you sure you want to remove this manager from your account?',
                                          confirmButtonName: 'Remove',
                                          confirmBorderColor: AppColors.cFF3939,
                                          confirmTextColor: AppColors.cFF3939,
                                          cancleButtonName: 'Cancel',
                                          yesTap: () async {
                                            await _deleteManager(manager.id!);
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 9.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                          border: Border.all(
                                            color: AppColors.cADADAD.withValues(
                                              alpha: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          Assets.icons.deleteIcon,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      /// HanZi icon — bottom of list, overlaying
                      Positioned(
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            Assets.images.hanziIcon.path,
                            height: 45.h,
                            width: 112.w,
                            color: AppColors.cE4E4E4.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
