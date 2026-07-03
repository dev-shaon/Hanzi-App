import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tc_mcandy/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tc_mcandy/common_widgets/custom_shimmer.dart';
import 'package:tc_mcandy/helpers/share_helper.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/common_widgets/custom_button.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/model/celebrity_details_model.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/connect_widget.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/custom_con.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/custom_rich_text.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/frist_step.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/p_d_r_widget.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/play_cart.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/widgets/reviews.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

import '../../../../helpers/all_routes.dart';
import '../../../../helpers/helpers_method.dart';

class CelebrityDetails extends StatefulWidget {
  final int id;

  const CelebrityDetails({super.key, required this.id});

  @override
  State<CelebrityDetails> createState() => _CelebrityDetailsState();
}

class _CelebrityDetailsState extends State<CelebrityDetails> {
  bool isFollowLoading = false;
  bool? isFollow;
  bool _isPageLoading = true;
  bool? _apiIsFollowing;

  @override
  void initState() {
    super.initState();
    getCelebrityDetails();
  }

  void getCelebrityDetails() async {
    if (mounted) setState(() => _isPageLoading = true);
    await getCelebrityDetailsRxObj.fetchCelebrityDetails(id: widget.id);
    if (mounted) setState(() => _isPageLoading = false);
  }

  void postFollow() async {
    try {
      setState(() => isFollowLoading = true);
      bool success = await postFollowRxObj.postFollow(id: widget.id);
      if (success) {
        setState(() {
          isFollow = !(isFollow ?? _apiIsFollowing ?? false);
        });
      }
    } catch (e) {
      customToastMessage("Error", "Follow Unsuccessful");
    } finally {
      if (mounted) setState(() => isFollowLoading = false);
    }
  }

  Future<void> _sendDM() async {
    try {
      String? clientSecret = await postChatPaymentRxObj.post(
        celebrityId: widget.id,
      );

      if (clientSecret != null) {
        await _presentPaymentSheet(clientSecret);
      }
    } catch (e) {
      log(e.toString());
      customToastMessage("Error", kErrorGeneric);
    } finally {
      if (mounted) {}
    }
  }

  Future<void> _presentPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "TC MCandy",
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (mounted) {
        customToastMessage("Success", "Message sent successfully!");
        getCelebrityDetails();
        getChatListRxObj.fetchChatList();
      }
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        customToastMessage("Cancelled", "Payment cancelled");
      } else {
        customToastMessage("Error", e.error.message ?? "Payment failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getCelebrityDetailsRxObj.fillData,
      builder: (context, asyncSnapshot) {
        final CelebrityDetailsModel? get = asyncSnapshot.data;
        if (get != null) _apiIsFollowing = get.data?.isFollowing;

        String getTierIcon(String? tier) {
          if (tier == null) return Assets.icons.star1;
          final lowercaseTier = tier.toLowerCase();
          if (lowercaseTier == 'vip') return Assets.icons.star2;
          if (lowercaseTier == 'foundation') return Assets.icons.star3;
          return Assets.icons.star1;
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: CustomAppBar(
              title: "",
              showFilter: false,
              ontap: () {
                NavigationService.goBack;
                getFollowingListRxObj.fetchFollowingList();
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: InkWell(
                  onTap: () {
                    if (get?.data != null) {
                      ShareHelper.shareProfile(
                        id: get!.data!.id!,
                        name: get.data?.name ?? "Celebrity",
                        profession: get.data?.profession,
                      );
                    }
                  },
                  child: SvgPicture.asset(Assets.icons.sheareIcon),
                ),
              ),
            ],
            backgroundColor: AppColors.cFFFFF8,
          ),
          body: SafeArea(
            child: asyncSnapshot.hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Failed to load details. Please try again.",
                          style: TextFontStyle.headline16w500c202020urbanist,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isPageLoading
                            ? const CustomShimmer(
                                type: ShimmerType.headerShimmer,
                              )
                            : FristStep(
                                title: get?.data?.name ?? "Samuel",
                                subtitle:
                                    get?.data?.profession ?? "Web Designer",
                                avatar:
                                    get?.data?.avatar ?? kDefaultProfileImage,
                                onTap: () => postFollow(),
                                isFollow: isFollow ?? get?.data?.isFollowing,
                                isLoading: isFollowLoading,
                                tierIcon: getTierIcon(get?.data?.tier),
                              ),
                        UIHelper.verticalSpace(18.h),
                        get?.data?.videos?.isEmpty ?? true
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: 180,
                                child: _isPageLoading
                                    ? const CustomShimmer(
                                        type: ShimmerType.horizontalBoxShimmer,
                                        boxWidth: 150,
                                        boxHeight: 180,
                                      )
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: get?.data?.videos?.length,
                                        itemBuilder: (context, index) {
                                          CelebrityVideo? item =
                                              get?.data?.videos?[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: 12.w,
                                            ),
                                            child: PlayCart(
                                              onTap: () {
                                                NavigationService.navigateToWithArgs(
                                                  Routes.videoScreen,
                                                  {
                                                    "video_url": item?.videoUrl,
                                                    "id": get!.data!.id,
                                                  },
                                                );
                                                log(get.data!.id.toString());
                                              },
                                              videoUrl: item?.videoUrl,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                        if (!_isPageLoading) ...[
                          UIHelper.verticalSpace(24.h),
                          Text(
                            "Get a custom video",
                            style: TextFontStyle.headline18w600c303030urbanist,
                          ),
                          UIHelper.verticalSpace(12.h),
                          PDRWidget(
                            price: "\$${get?.data?.startPrice}+",
                            delivery:
                                "${get?.data?.deliveryDaysRange?[0]}-${get?.data?.deliveryDaysRange?[1]} days",
                            reviews:
                                "${get?.data?.averageRating} (${get?.data?.reviews?.length})",
                          ),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            "Reasons to get a video",
                            style: TextFontStyle.headline18w600c303030urbanist,
                          ),
                          UIHelper.verticalSpace(12.h),
                          CustomContainer(items: get?.data?.tags ?? []),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            "What to expect",
                            style: TextFontStyle.headline18w600c303030urbanist,
                          ),
                          UIHelper.verticalSpace(8.h),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.task),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                "Write a short set of instructions",
                                style: TextFontStyle
                                    .headline16w500c202020urbanist
                                    .copyWith(color: AppColors.c303030),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(8.h),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.music),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                "Share the magic",
                                style: TextFontStyle
                                    .headline16w500c202020urbanist
                                    .copyWith(color: AppColors.c303030),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(8.h),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.camera),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                "Get your video",
                                style: TextFontStyle
                                    .headline16w500c202020urbanist
                                    .copyWith(color: AppColors.c303030),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(24.h),
                          if (get?.data?.isSubscribed != true)
                            ConnectWidget(
                              messageOnTap: () {
                                showCustomDialog(
                                  context: context,
                                  titile: 'Send DM',
                                  subTitile:
                                      'Please note that while a Hanzi DM increases your chances of hearing back from a Celebrity, there\'s no guarantee that they will reply back, so by paying you accept the risk that you may not hear back from the Celebrity.',
                                  confirmButtonName: 'Continue',
                                  confirmBorderColor: AppColors.cFF3939,
                                  confirmTextColor: AppColors.cFF3939,
                                  cancleButtonName: 'Cancel',
                                  yesTap: () async {
                                    await _sendDM();
                                  },
                                );
                              },
                            ),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            "More about ${get?.data?.name}",
                            style: TextFontStyle.headline18w600c303030urbanist,
                          ),
                          UIHelper.verticalSpace(16.h),
                          Text(
                            get?.data?.description ?? "",
                            style: TextFontStyle.headline16w500c7C7C7Curbanist,
                          ),
                          UIHelper.verticalSpace(16.h),
                          CustomRichText(
                            text1: "Age:",
                            text2: " ${get?.data?.age}",
                          ),
                          UIHelper.verticalSpace(8.h),
                          CustomRichText(
                            text1: "Birthday:",
                            text2:
                                " ${get?.data?.birthday?.day}-${get?.data?.birthday?.month}-${get?.data?.birthday?.year}",
                          ),
                          UIHelper.verticalSpace(8.h),
                          CustomRichText(
                            text1: "Totem:",
                            text2: " ${get?.data?.totem}",
                          ),
                          UIHelper.verticalSpace(8.h),
                          CustomRichText(
                            text1: "Joined HanZi:",
                            text2: " ${get?.data?.joinedDate}",
                          ),
                          UIHelper.verticalSpace(16.h),
                          CustomContainer(items: get?.data?.serviceTypes ?? []),
                          UIHelper.verticalSpace(24.h),
                          Text(
                            "Recent reviews",
                            style: TextFontStyle.headline18w600c303030urbanist,
                          ),
                          UIHelper.verticalSpace(8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Assets.icons.starIcon),
                                  UIHelper.horizontalSpace(6.w),
                                  Text(
                                    "${get?.data?.averageRating} (${get?.data?.reviews?.length})",
                                    style: TextFontStyle
                                        .headline14w500cFF5C24urbanist
                                        .copyWith(
                                          color: AppColors.c7C7C7C,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(16.h),
                          get?.data?.reviews?.isEmpty ?? true
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: 70.h,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: get?.data?.reviews?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      CelebrityReview? review =
                                          get?.data?.reviews?[index];
                                      String formattedDate = "";
                                      if (review?.createdAt != null) {
                                        formattedDate = DateFormat(
                                          'MMM dd, yyyy',
                                        ).format(review!.createdAt!);
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: Reviews(
                                          name: review?.fan?.name ?? "Fan",
                                          rating:
                                              review?.rating?.toString() ?? "0",
                                          date: formattedDate,
                                          reviewText:
                                              review?.review?.toString() ?? "",
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          UIHelper.verticalSpace(16.h),
                          CustomButton(
                            onTap: () {
                              NavigationService.navigateToWithArgs(
                                Routes.placeOrder,
                                {"id": widget.id},
                              );
                            },
                            btnName: "Book now \$${get?.data?.startPrice}+",
                          ),
                          UIHelper.verticalSpace(8.h),
                        ],
                      ],
                    ),
                  ),
          ),
          floatingActionButton: SizedBox(
            height: 40.h,
            width: 40.w,
            child: FloatingActionButton(
              onPressed: () {
                NavigationService.navigateTo(Routes.customerSupportScreen);
              },
              backgroundColor: AppColors.cFFFFF8,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.cC7C7C7, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: SvgPicture.asset(
                  Assets.icons.aiIcon,
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
