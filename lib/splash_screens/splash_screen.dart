import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool split = false;
  bool showLogo = false;
  bool showSecondLogo = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        split = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        showLogo = true;
      });
    });

    Future.delayed( Duration(milliseconds: 2700), () {
      setState(() {
        showSecondLogo = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration:  Duration(milliseconds: 800),
              opacity: showSecondLogo ? 1 : 0,
              child: Image.asset(
                Assets.images.logo.path,
                height: 200.h,
                width: 200.w,
              ),
            ),
          ),

          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: showSecondLogo ? 0 : (showLogo ? 1 : 0),
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 800),
                offset: showLogo ? const Offset(-0.15, 0) : Offset.zero,
                child: Image.asset(
                  Assets.images.aLogo.path,
                  height: 200.h,
                  width: 200.w,
                ),
              ),
            ),
          ),

          if (!split)
            Container(
              width: w,
              height: h,
              color: AppColors.cAE0606,
            ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            left: split ? -w * 0.6 : 0,
            top: 0,
            child: ClipPath(
              clipper: ArrowClipper(),
              child: Container(
                width: w * 0.6,
                height: h,
                color: AppColors.cAE0606,
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            right: split ? -w * 0.6 : 0,
            top: 0,
            child: ClipPath(
              clipper: LeftCutClipper(),
              child: Container(
                width: w * 0.6,
                height: h,
                color: AppColors.cAE0606,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.9, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
