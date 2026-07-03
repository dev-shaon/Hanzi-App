import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/common_widgets/custom_app_bar.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/widget/video_card.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/helpers/all_routes.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class SavedVideoScreen extends StatefulWidget {
  const SavedVideoScreen({super.key});

  @override
  State<SavedVideoScreen> createState() => _SavedVideoScreenState();
}

class _SavedVideoScreenState extends State<SavedVideoScreen> {
  @override
  void initState() {
    super.initState();
    _getSaveVideo();
  }

  void _getSaveVideo() async {
    await getSaveVideoRxObj.fetchSaveVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(title: "Saved Videos", showFilter: false),
        centerTitle: true,
        backgroundColor: AppColors.cFFFFF8,
        elevation: 7,
        shadowColor: AppColors.cC7C7C7.withValues(alpha: 0.1),
      ),
      body: StreamBuilder(
        stream: getSaveVideoRxObj.fillData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final get = snapshot.data!.data ?? [];

          if (get.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Browse creators to view videos.\nAnd save videos.",
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline16w500c202020urbanist.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateToReplacement(
                        Routes.navberScreen,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: const Color(0xFFE85C2B),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Start browsing",
                        style: TextFontStyle.headline16w500c202020urbanist
                            .copyWith(
                              color: const Color(0xFFE85C2B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 14,
                childAspectRatio: 160.w / 210.h,
              ),
              itemCount: get.length,
              itemBuilder: (context, index) {
                final item = get[index];
                return VideoCard(
                  onTap: () {
                    NavigationService.navigateToWithArgs(Routes.videoScreen, {
                      "video_url": item?.videoUrl,
                      "id": item?.celebrityId,
                    });
                  },
                  videoUrl: item?.videoUrl,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
