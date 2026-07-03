// ignore_for_file: constant_identifier_names

final class AppRegExpText {
  AppRegExpText._();
  // Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
      "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}

const String kKeyAccessToken = "kKeyAccessToken";
const String kKeyRefreshToken = "kKeyRefreshToken";
const String kKeyIsLoggedIn = "kKeyIsLoggedIn";
const String kKeyUserId = "kKeyUserId";
const String kKeyDeviceID = "kKeyDeviceID";
const String kKeyFCMToken = "kKeyFCMToken";
const String kKeyIsFirstTime = "kKeyIsFirstTime";
const String KKeyUserCurrentLat = 'KKeyUserCurrentLat';
const String KKeyUserCurrentLng = 'KKeyUserCurrentLng';
const String KKeyroleSelected = 'KKeyroleSelected';
const String kkeyUserRole = "KKeyUserRole";
const String KKeyEmail = 'KKeyEmail';
const String KKeyOtp = 'KKeyOtp';
const String kkeyname = 'kkeyname';
const String kkeynumber = 'kkeynumber';
const String kkeyhasPackage = 'kkeyhasPackage';
const String kkeyCategoryId = 'kkeyCategoryId';
const String orderId = 'orderId';
const String kkeyManagerOtp = 'kkeyManagerOtp';
const String kkeyIsManager = 'kkeyIsManager';

const String KKeyIsVerificationPending = 'is_verification_pending';
const String KKeyPendingEmail = 'pending_email';
const String KKeyPendingRole = 'pending_role';

const String KKeyForgetToken = 'KKeyForgetToken';

const String kKeyEnglish = 'en';
const String kKeyFrench = 'fr';

const List<String> kLanguagesKey = [kKeyEnglish, kKeyFrench];
const Map languages = <String, String>{
  kKeyEnglish: "English",
  kKeyFrench: "French",
};

const Map countriesCode = <String, String>{kKeyEnglish: "US", kKeyFrench: "FR"};

// Default Images
const String kDefaultProfileImage = "";

// Error Messages
const String kErrorGeneric = "Something went wrong";
const String kErrorNoConnection = "Check Your Network Connection";

// Global session expired flag
class AppSessionState {
  static bool isSessionExpired = false;
}

// Stripe
const String kStripePublishableKey = String.fromEnvironment(
  'STRIPE_PUBLISHABLE_KEY',
  defaultValue:
      'pk_test_51T4wTaGhUagXjusb8XLITa3YC0jbhqAUMQojgmeRtz6lC2ODUzY959uhzcuWel7yNm5EstNArKsypCwhHQqVSBhm00DCdHCASA',
);
