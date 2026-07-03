import 'dart:developer';

import '../constants/app_constants.dart';
import '../helpers/all_routes.dart';
import '../helpers/di.dart';
import '../helpers/navigation_service.dart';

bool _isHandlingUnauthorized = false;
bool _isTokenRefreshInProgress = false;

Future<void> totalDataClean() async {
  await appData.write(kKeyIsLoggedIn, false);
  // await appData.write(kKeyRole, '');
}

/// Show a subtle message that token refresh is in progress
/// This won't interrupt user experience, just a background operation
void showTokenRefreshInProgress() {
  if (_isTokenRefreshInProgress) return;
  _isTokenRefreshInProgress = true;

  log('🔄 Token refresh in progress...');
  // Optionally show a subtle snackbar if needed
  // customToastMessage('Refreshing session', '', duration: 1);

  Future.delayed(const Duration(seconds: 5), () {
    _isTokenRefreshInProgress = false;
  });
}

/// Call this from any rx.dart when a 401 is received.
/// Only the first call will show a toast and navigate to sign-in.
/// Subsequent calls within the same cycle are silently ignored.
void handleUnauthorized() {
  if (_isHandlingUnauthorized) return;
  _isHandlingUnauthorized = true;

  // Set global session expired flag
  AppSessionState.isSessionExpired = true;

  totalDataClean();
  NavigationService.navigateToReplacementUntil(Routes.signinRoute);

  // Reset the flag after a short delay so future genuine 401s are handled.
  Future.delayed(const Duration(seconds: 2), () {
    _isHandlingUnauthorized = false;
  });
}
