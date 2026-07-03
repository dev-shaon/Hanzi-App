# Smart Token Refresh Strategy - User Experience Optimized

## 🎯 Goal
**Token অটোম্যাটিক্যালি refresh হোক, user logout না হোক**

---

## 📊 Token Lifecycle

### Phase 1: Normal Operation (0 - 55 minutes)
```
✅ User makes API calls
✅ Token is valid
✅ Requests succeed normally
```

### Phase 2: Token Expiry (55-60 minutes)
```
⚠️ Token expires silently
→ API request gets 401 response
→ TokenInterceptor automatically catches it
→ Tries to refresh token using refresh_token
→ (User doesn't notice anything)
```

### Phase 3: Token Refresh Success (60-65 minutes)
```
✅ Refresh succeeds
✅ New token saved to storage
✅ Failed request is automatically retried with new token
✅ User continues working seamlessly
🔄 No logout, no interruption
```

### Phase 4: Refresh Failure with Retries (65+ minutes)
```
❌ First refresh attempt fails (network issue)
   → Wait 500ms, retry (attempt 1/3)
❌ Second attempt fails
   → Wait 1000ms, retry (attempt 2/3)  
❌ Third attempt fails
   → Wait 2000ms, final retry (attempt 3/3)
❌ All retries exhausted
   → Show "Session Expired" message
   → Redirect to login
```

---

## 🔧 How It Works

### TokenInterceptor Flow

```dart
API Request with Bearer Token
        ↓
Response 401 Unauthorized
        ↓
TokenInterceptor.onError()
        ↓
Skip if: Refresh endpoint, Login endpoint, Already retry
        ↓
Is another refresh in progress?
  ├─ YES → Queue this request
  └─ NO → Start refresh process
        ↓
_refreshTokenWithRetry() - (3 retries with exponential backoff)
        ├─ Try 1 (delay 500ms)
        ├─ Try 2 (delay 1000ms)
        ├─ Try 3 (delay 2000ms)
        ↓
Refresh successful?
  ├─ YES ✅
  │   ├─ Save new token
  │   ├─ Retry original request
  │   ├─ Retry all queued requests
  │   └─ User continues working
  └─ NO ❌
      ├─ Check if refresh token is invalid (401)
      │   └─ YES → Logout (refresh token expired)
      ├─ Check if network error
      │   └─ YES → Retry again? (handled by retry logic)
      └─ Call handleUnauthorized() → Logout
```

---

## 🚀 Improved Token Refresh Logic

### Exponential Backoff Retry
```
Attempt 1: Wait 500ms   (0.5 seconds)
Attempt 2: Wait 1000ms  (1 second)
Attempt 3: Wait 2000ms  (2 seconds)
```

### Smart Error Handling
```dart
if (response.statusCode == 401) {
  // Refresh token is invalid
  return false; // Logout
}

if (error is DioException && error.type == connectionError) {
  // Network issue, retry
  throw Exception('Network error');
}

// Try up to 3 times
```

---

## 📝 Code Changes

### 1. TokenInterceptor (Updated)
- Added `_refreshTokenWithRetry()` method with exponential backoff
- Added `_refreshRetryCount` and `_maxRefreshRetries` constants
- Network errors trigger retries instead of immediate logout
- 401 on refresh endpoint causes logout (refresh token invalid)
- Retryable errors (network timeouts) are retried

### 2. stream_cleaner.dart (Updated)
- Added `showTokenRefreshInProgress()` for subtle warnings
- Added `_isTokenRefreshInProgress` flag
- Can show optional snackbar during refresh

---

## ✅ Expected Behavior

### Scenario 1: Normal Token Expiry
```
1:00:00 - Token expires
1:00:01 - User makes API request → 401
1:00:02 - TokenInterceptor refreshes token
1:00:03 - Request retried with new token ✅
        - User sees nothing
```

### Scenario 2: Temporary Network Issues
```
1:00:00 - Token expires
1:00:01 - Refresh network error
1:00:01.5 - Retry (wait 500ms)
1:00:02 - Refresh network error
1:00:03 - Retry (wait 1000ms)
1:00:04 - REFRESHED ✅
1:00:04.1 - Request retried ✅
          - User continues working
```

### Scenario 3: Persistent Failure (Refresh Token Invalid)
```
1:00:00 - Token expires
1:00:01 - Refresh gets 401 (refresh token invalid)
1:00:02 - handleUnauthorized() called
        - Show "Session Expired"
        - Redirect to login
        - User must login again
```

---

## 🎨 User Experience

### What User Sees:
✅ **Best Case**: Nothing - token refreshes silently
✅ **Network Issue**: Slight delay but continues working
❌ **Refresh Token Invalid**: Single "Session Expired" message

### What User Does NOT See:
❌ Multiple error toasts
❌ Unnecessary logouts
❌ "Something went wrong" messages
❌ Interrupted workflow

---

## ⚙️ Configuration

### Token Expiry Times
Your backend likely returns token with expiry:
```json
{
  "token": "eyJ...",
  "expires_in": 3600,           // 1 hour
  "refresh_token": "refresh...",
  "refresh_expires_in": 604800   // 7 days
}
```

### Recommended Refresh Strategy
1. **Token Lifetime**: 1 hour (standard)
2. **Refresh Token Lifetime**: 7 days
3. **Retry Strategy**: 3 attempts with exponential backoff
4. **Max Token Age Before Forced Refresh**: 55 minutes (refresh 5 min early)

### Optional: Proactive Token Refresh
```dart
// In your app initialization:
void startTokenRefreshTimer() {
  // If token expires in 5 minutes, refresh it now
  final expiresAt = DateTime.parse(appData.read(kKeyTokenExpiresAt));
  final timeUntilExpiry = expiresAt.difference(DateTime.now());
  
  if (timeUntilExpiry.inMinutes <= 5) {
    // Refresh token now, before it actually expires
    _refreshTokenSilently();
  }
}
```

---

## 📋 Summary of Changes

| File | Change | Impact |
|------|--------|--------|
| `token_interceptor.dart` | Added retry logic with exponential backoff | Handles temporary network issues gracefully |
| `stream_cleaner.dart` | Added token refresh status tracking | Better logging and optional UI feedback |
| All `rx.dart` files | Use `handleUnauthorized()` consistently | Single logout experience |

---

## 🐛 Troubleshooting

### If user is still getting logged out:
1. Check logs for "Token refreshed successfully" ✅
2. Check if refresh token is valid (7 days old?)
3. Check if backend refresh endpoint is working
4. Check network connectivity

### If seeing multiple toasts:
1. Ensure all rx.dart files use `handleUnauthorized()`
2. Check `_isHandlingUnauthorized` flag logic
3. Clear app cache and restart

### If requests are slow after token refresh:
1. This is normal (retry happens automatically)
2. Check for logs: `Token refreshed successfully` 
3. Monitor network latency to refresh endpoint

---

## 🔒 Security Notes

- ✅ Refresh token never exposed to frontend (in HTTP-only cookie best practice)
- ✅ Each request retried only once automatically
- ✅ Refresh token changed on each successful refresh
- ✅ Both tokens cleared on logout
- ✅ Session state tracked globally (`AppSessionState.isSessionExpired`)

---

## 📞 Questions?

See logs for detailed flow:
```
✅ Token refreshed successfully
⚠️ Network error during token refresh: connectionTimeout - Will retry
❌ Token refresh is invalid (401 from server)
❌ Refresh token is invalid (401 from server)
```
