import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class AboutProfession extends StatefulWidget {
  const AboutProfession({super.key});

  @override
  State<AboutProfession> createState() => _AboutProfessionState();
}

class _AboutProfessionState extends State<AboutProfession> {
  final TextEditingController videoCategoryController = TextEditingController();
  final TextEditingController serviceTagController = TextEditingController();

  final FocusNode _videoCategoryFocus = FocusNode();
  final FocusNode _serviceTagFocus = FocusNode();

  List<String> videoCategories = [];
  List<String> serviceTags = [];

  final TextEditingController detailsController = TextEditingController();

  @override
  void dispose() {
    _videoCategoryFocus.dispose();
    _serviceTagFocus.dispose();
    videoCategoryController.dispose();
    serviceTagController.dispose();
    detailsController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bool hasBio = detailsController.text.trim().isNotEmpty;
    final bool isActive = detailsController.text.trim().isNotEmpty &&
        videoCategories.isNotEmpty &&
        serviceTags.isNotEmpty;
    final bool showVideoCategoryError = hasBio && videoCategories.isEmpty;
    final bool showServiceTagError = hasBio && serviceTags.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(title: "", showFilter: false),
        backgroundColor: AppColors.cFFFFF8,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What else do fans know you for?",
                  style: TextFontStyle.headline24w600c303030urbanist,
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  "List out all of the things you are known for. We'll display this bio on your profile, but you can edit it later.",
                  style: TextFontStyle.headline16w500c7C7C7Curbanist,
                ),
                UIHelper.verticalSpace(33.h),
                CustomFormField(
                  controller: detailsController,
                  maxline: 8,
                  minline: 8,
                  maxLength: 200,
                  onChanged: (_) => setState(() {}),
                  hintText:
                      "Make sure you list things you've been apart of such as movies, shows, etc...",
                ),

                UIHelper.verticalSpace(20.h),
                Text(
                  "Add your profile category & tags",
                  style: TextFontStyle.headline24w600c303030urbanist,
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  "Category & tags will help peoples to find out the correct person to give the order. You should be careful on this.",
                  style: TextFontStyle.headline16w500cADADADurbanist,
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  "Video category",
                  style: TextFontStyle.headline16w500c202020urbanist,
                ),
                UIHelper.verticalSpace(8.h),
                Column(
                  children: [
                    CustomFormField(
                      controller: videoCategoryController,
                      focusNode: _videoCategoryFocus,
                      hintText: "Enter video categories",
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty && videoCategories.length < 10) {
                          setState(() {
                            videoCategories.add(value);
                            videoCategoryController.clear();
                          });
                        }
                        _videoCategoryFocus.requestFocus();
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
                    Align(alignment: Alignment.centerRight,child: Text("${videoCategories.length}/10"))
                  ],
                ),
                if (showVideoCategoryError) ...[
                
                  Text(
                    "At least 1 video category is required",
                    style: TextFontStyle.headline14w400cADADADurbanist.copyWith(
                      color: AppColors.cBF0707,
                      fontSize: 12.sp
                    ),
                  ),
                ],
                Wrap(
                  spacing: 8,
                  children: videoCategories.map((item) {
                    return Chip(
                      backgroundColor: AppColors.cFFA46C.withValues(alpha: 0.5),
                      label: Text(
                        item,
                        style: TextFontStyle.headline14w400cADADADurbanist
                            .copyWith(color: AppColors.c000000),
                      ),
                      onDeleted: () {
                        setState(() {
                          videoCategories.remove(item);
                        });
                      },
                    );
                  }).toList(),
                ),

                UIHelper.verticalSpace(30.h),
                Text(
                  "Service tags",
                  style: TextFontStyle.headline16w500c202020urbanist,
                ),
                UIHelper.verticalSpace(8.h),

                Column(
                  children: [
                    CustomFormField(
                      controller: serviceTagController,
                      focusNode: _serviceTagFocus,
                      hintText: "Enter service tags ",
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty && serviceTags.length < 5) {
                          setState(() {
                            serviceTags.add(value);
                            serviceTagController.clear();
                          });
                        }
                        _serviceTagFocus.requestFocus();
                      },
                    ),
                    UIHelper.verticalSpace(4.h),
                    Align(alignment: Alignment.centerRight,child: Text("${serviceTags.length}/5"))
                  ],
                ),
                if (showServiceTagError) ...[
                  Text(
                    "At least 1 service tag is required",
                    style: TextFontStyle.headline14w400cADADADurbanist.copyWith(
                      color: AppColors.cBF0707,
                      fontSize: 12.sp
                    ),
                  ),
                ],
                Wrap(
                  spacing: 8,
                  children: serviceTags.map((item) {
                    return Chip(
                      backgroundColor: AppColors.cFFA46C.withValues(alpha: 0.5),
                      label: Text(
                        item,
                        style: TextFontStyle.headline14w400cADADADurbanist
                            .copyWith(color: AppColors.c000000),
                      ),
                      onDeleted: () {
                        setState(() {
                          serviceTags.remove(item);
                        });
                      },
                    );
                  }).toList(),
                ),

                UIHelper.verticalSpace(20.h),

                CustomButton(
                  isGradient: true,
                  isActive: isActive,
                  onTap: isActive
                      ? () {
                          NavigationService.navigateToWithArgs(Routes.setPackages, {
                            'celebrityBio': detailsController.text,
                            'videoCategory': videoCategories,
                            'serviceTags': serviceTags,
                          });
                        }
                      : null,
                  btnName: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
