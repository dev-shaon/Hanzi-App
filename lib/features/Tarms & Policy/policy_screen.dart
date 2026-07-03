import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tc_mcandy/gen/assets.gen.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  final String htmlData = """
  <h2>Terms of services</h2>
  <p><small>Last update on july 2025</small></p>

  <h3>1. What is Lorem Ipsum?</h3>
  <p>
  Lorem ipsum dolor sit amet consectetur. Maecenas dui odio vitae convallis. 
  Euismod ac ut sed tempor duis et. Auctor ornare egestas in iaculis rhoncus. 
  Venenatis urna nibh adipiscing elementum blandit nulla pharetra blandit. 
  Vulputate eu augue eu diam et sit. Varius a nunc enim euismod quisque vitae. 
  Eget consequat arcu nam blandit maecenas adipiscing tristique.
   Odio nisi at odio eu nunc dictumst eros phasellus. Fringilla condimentum duis id adipiscing. 
   Cursus vitae dignissim est turpis 
  </p>

  <h3>2. What do we use it?</h3>
  <p>
  Lorem ipsum dolor sit amet consectetur. 
  Maecenas dui odio vitae convallis. Euismod ac ut sed tempor duis et. 
  Auctor ornare egestas in iaculis rhoncus. 
  Venenatis urna nibh adipiscing elementum blandit nulla pharetra blandit. Vulputate eu augue eu diam et sit. 
  Varius a nunc enim euismod quisque vitae. Eget consequat arcu nam blandit maecenas adipiscing tristique. 
  Odio nisi at odio eu nunc dictumst eros phasellus. Fringilla condimentum duis id adipiscing. Cursus vitae 
  </p>

  <h3>3. How it works?</h3>
  <p>
  Lorem ipsum dolor sit amet consectetur. 
  Maecenas dui odio vitae convallis. Euismod ac ut sed tempor duis et. 
  Auctor ornare egestas in iaculis rhoncus. Venenatis urna nibh adipiscing elementum blandit nulla pharetra blandit. 
  Vulputate eu augue eu diam et sit. Varius a nunc enim euismod quisque vitae. 
  Eget consequat arcu nam blandit maecenas adipiscing tristique. Odio nisi at odio eu nunc dictumst eros phasellus. 
  Fringilla condimentum duis id adipiscing. Cursus vitae 
  </p>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF5),
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFF8,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: InkWell(
            onTap: () {
              NavigationService.goBack;
            },
            child: SvgPicture.asset(Assets.icons.arrowBack),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Html(
          data: htmlData,
          style: {
            "h2": Style(
              fontSize: FontSize(22),
              fontWeight: FontWeight.bold,
              color: AppColors.c000000,
            ),
            "h3": Style(
              fontSize: FontSize(16),
              fontWeight: FontWeight.w600,
              margin: Margins.only(top: 16, bottom: 8),
            ),
            "p": Style(
              fontSize: FontSize(14),
              lineHeight: LineHeight(1.6),
              color: AppColors.c7C7C7C,
            ),
            "small": Style(fontSize: FontSize(12), color: Colors.grey),
          },
        ),
      ),
    );
  }
}
