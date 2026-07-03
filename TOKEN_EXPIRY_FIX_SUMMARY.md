# Token Expiration & 401 Error Handling - Fix Summary

## Problem Identified
When a token expires (after 1 hour as you mentioned), the app receives multiple 401 error responses. Each failed API request was showing its own error toast message, resulting in **multiple "Something went wrong" messages** appearing at once.

## Root Cause
- 20 different `rx.dart` files were handling 401 errors independently
- Each file would call `customToastMessage('Error', message)` even for 401 responses
- When multiple API requests failed due to token expiration, multiple toasts appeared

## Solution Implemented

### 1. Unified 401 Error Handling (20 Files Fixed)
All `rx.dart` files now use the centralized `handleUnauthorized()` function from [lib/networks/stream_cleaner.dart](lib/networks/stream_cleaner.dart) instead of handling it individually.

**Old Pattern (❌ WRONG):**
```dart
if (error.response?.statusCode == 401) {
  totalDataClean();
  appData.write(kKeyIsLoggedIn, false);
  NavigationService.navigateToReplacementUntil(Routes.signinRoute);
} else {
  message = error.response?.data["message"].toString() ?? kErrorGeneric;
}
customToastMessage('Error', message); // ❌ Shows error toast even for 401!
```

**New Pattern (✅ CORRECT):**
```dart
if (error.response?.statusCode == 401) {
  handleUnauthorized(); // Centralized handler
  return false;         // Exit early - don't show toast
} else {
  message = error.response?.data["message"].toString() ?? kErrorGeneric;
}
customToastMessage('Error', message); // ✅ Only shows for non-401 errors
```

### 2. How `handleUnauthorized()` Works
- Uses a flag (`_isHandlingUnauthorized`) to prevent duplicate toasts
- Only the first 401 shows a toast and navigates to sign-in
- Subsequent 401s are silently ignored within 2 seconds
- Shows single "Session Expired" message instead of multiple errors

```dart
void handleUnauthorized() {
  if (_isHandlingUnauthorized) return;
  _isHandlingUnauthorized = true;
  
  AppSessionState.isSessionExpired = true;
  totalDataClean();
  customToastMessage('Session Expired', 'Please sign in again');
  NavigationService.navigateToReplacementUntil(Routes.signinRoute);
  
  Future.delayed(const Duration(seconds: 2), () {
    _isHandlingUnauthorized = false;
  });
}
```

### 3. Automatic Token Refresh (Already Implemented)
Your [TokenInterceptor](lib/networks/dio/token_interceptor.dart) already handles token refresh automatically:
- When a 401 is received, it attempts to refresh the token using the refresh token
- If successful, it retries the original request with the new token
- If refresh fails, it calls `handleUnauthorized()` once

**Files Fixed (20 total):**
1. ✅ lib/features/fan_side/leaderboard/data/get_leaderboard/rx.dart
2. ✅ lib/features/fan_side/profile/data/rx_get_order/rx.dart
3. ✅ lib/features/fan_side/following/data/rx_following_list/rx.dart
4. ✅ lib/features/fan_side/celebrity_details/data/rx_get_celebrity_details/rx.dart
5. ✅ lib/features/fan_side/profile/data/rx_get_user_profile/rx.dart
6. ✅ lib/features/fan_side/message/data/get_chat_list/rx.dart
7. ✅ lib/features/celebrity side/celebrity_navber/wallet/data/rx_get_wallet/rx.dart
8. ✅ lib/features/celebrity side/celebrity_navber/wallet/data/rx_get_earnings/rx.dart
9. ✅ lib/features/celebrity side/celebrity_navber/packages/data/get_celebrity_package/rx.dart
10. ✅ lib/features/celebrity side/manager_section/data/get_managers/rx.dart
11. ✅ lib/features/celebrity side/talent_profile/profession/data/get_profession_category/rx.dart
12. ✅ lib/features/auth/data/rx_forget_email_send/rx.dart
13. ✅ lib/features/auth/data/rx_manager_resend_otp/rx.dart
14. ✅ lib/features/auth/data/rx_reset_pass/rx.dart
15. ✅ lib/features/auth/data/rx_send_manager_otp/rx.dart
16. ✅ lib/features/auth/data/rx_signup/rx.dart
17. ✅ lib/features/auth/data/rx_login/rx.dart
18. ✅ lib/features/auth/data/rx_talent_profile/rx.dart
19. ✅ lib/features/auth/data/rx_signup_get_otp/rx.dart
20. ✅ lib/features/fan_side/category_details/data/search_filer/rx.dart
21. ✅ lib/features/settings/data/rx_get_profile/rx.dart

## How Token Refresh Works

### Timeline:
1. **User makes API request** → Token is included in Authorization header
2. **Server returns 401** → Token is expired or invalid
3. **TokenInterceptor catches it** → Attempts to refresh token using refresh_token
4. **If refresh succeeds** → Retries original request with new token (transparent to user)
5. **If refresh fails** → Calls `handleUnauthorized()` → User redirected to sign-in once
6. **Multiple failed requests** → Only ONE "Session Expired" toast appears

### Pending Requests Queue
The TokenInterceptor also queues requests that come in during token refresh:
- While refreshing, new requests are queued
- After refresh succeeds, ALL queued requests are retried with new token
- This prevents request failures during the refresh process

## Testing the Fix

### To test token expiration:
1. Run the app and log in
2. Get the access token from storage (or manually expire it by editing local.properties)
3. Make an API request - should show "Session Expired" message **ONE TIME ONLY**
4. Multiple simultaneous requests should show single toast, not multiple
5. App should redirect to sign-in screen

### What should happen:
- ✅ Single "Session Expired" toast appears
- ✅ Single navigation to sign-in (not multiple)
- ✅ All pending requests are queued and retried after refresh (if refresh succeeds)
- ❌ Multiple error toasts should NOT appear

## Important Notes

### Token Refresh Before Expiry
For better UX, consider refreshing the token **before it expires**:
```dart
// In your app initialization or profile rx
if (tokenExpiresAt != null) {
  final expiresIn = tokenExpiresAt.difference(DateTime.now());
  // Refresh token 5 minutes before it expires
  Future.delayed(expiresIn - Duration(minutes: 5), () {
    _refreshToken(); // silently refresh
  });
}
```

### Session Expiry Flag
After fixing, you can use `AppSessionState.isSessionExpired` to:
- Show special UI for expired sessions
- Clear sensitive data from UI
- Prevent user actions before navigation completes

### Logging
Enable logs to see token refresh in action:
```
[log] Refresh token error: ...
[log] Token refreshed successfully
[GETX] REMOVING ROUTE /signin_screen
```

## Files Modified Summary
- All error handling in rx.dart files now centralized
- No breaking changes to API
- Backward compatible with existing code
- Imports already present in all files
