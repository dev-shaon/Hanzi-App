import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/common_widgets/custom_form_field.dart';
import 'package:tc_mcandy/features/fan_side/following/presentation/following_screen.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/home_screen.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';
import 'package:tc_mcandy/networks/api_access.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  final List<Widget> _screens = const [HomeScreen(), FollowingScreen()];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      getFollowingListRxObj.fetchFollowingList();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFEEE3D7), Color(0xFFE9CDC8)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: kToolbarHeight + 8.h,
                right: 8.w,
                left: 8.w,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: _isSearching
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomFormField(
                                focusNode: _searchFocusNode,
                                controller: _searchController,
                                fillColor: AppColors.c8C3314,
                                borderRadius: 26.w,
                                hintText: "Search Time Capsule...",
                                textInputAction: TextInputAction.search,
                              ),
                            ),
                            UIHelper.horizontalSpace(10.h),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSearching = false;
                                  _searchController.clear();
                                });
                                _searchFocusNode.unfocus();
                              },
                              child: const Icon(Icons.close, size: 26),
                            ),
                            UIHelper.horizontalSpace(6.h),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [],
                        ),
                ),
              ),

              Positioned(
                top: kToolbarHeight + 70.h,
                left: 0,
                right: 0,
                bottom: 70.h,
                child: IndexedStack(index: _currentIndex, children: _screens),
              ),

              Positioned(bottom: 0, child: _buildBottomNavigationBar()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 100.h),
          painter: _BottomCurvePainter(),
        ),
        Positioned(
          bottom: 30.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _onTabChanged(0),
                child: SvgPicture.asset(
                  Assets.icons.backIcon,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 0 ? Colors.white : const Color(0xFFEEE3D7),
                    BlendMode.srcIn,
                  ),
                  width: 64.w,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _onTabChanged(1),
                    child: SvgPicture.asset(
                      Assets.icons.runStar,
                      colorFilter: ColorFilter.mode(
                        _currentIndex == 1
                            ? Colors.white
                            : const Color(0xFFEEE3D7),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSearching = true;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _searchFocusNode.requestFocus();
                      });
                    },
                    child: _buildIcon(Assets.icons.aiIcon),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(String icon) {
    return SvgPicture.asset(icon);
  }
}

class _BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.allPrimaryColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.001);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.2,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      0,
      size.width,
      size.height * 0.25,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
