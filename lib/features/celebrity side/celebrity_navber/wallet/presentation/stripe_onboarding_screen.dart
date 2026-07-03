import 'package:flutter/material.dart';
import 'package:tc_mcandy/common_widgets/custom_toast.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeOnboardingScreen extends StatefulWidget {
  final String onboardingUrl;

  const StripeOnboardingScreen({
    super.key,
    required this.onboardingUrl,
  });

  @override
  State<StripeOnboardingScreen> createState() => _StripeOnboardingScreenState();
}

class _StripeOnboardingScreenState extends State<StripeOnboardingScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (_) {
            customToastMessage('Error', 'Failed to load Stripe onboarding page');
          },
        ),
      );

    final uri = Uri.tryParse(widget.onboardingUrl);
    if (uri == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        customToastMessage('Error', 'Invalid onboarding URL');
        if (mounted) {
          NavigationService.goBack;
        }
      });
      return;
    }

    _controller.loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cFFFFF8,
        leading: IconButton(
          onPressed: () {
            NavigationService.goBack;
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.c303030),
        ),
        title: Text(
          'Stripe account',
          style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
            color: AppColors.c303030,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.cBF0707),
            ),
        ],
      ),
    );
  }
}
