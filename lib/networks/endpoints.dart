// ignore_for_file: constant_identifier_names

const String url = "https://admin.hanziceleb.com/api";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class EndPoints {
  EndPoints._();
  static String login() => "/login";
  static String signup() => "/register";
  static String verifySignupOtp() => "/verify-email";

  static String postTalentProfile() => "/celebrity-register";

  static String getCelebrity() => "/celebrity-posts";

  static String verifyOtp() => "/verify-otp";
  static String forgotPass() => "/forget-password";
  static String verifyForgetPass() => "/otp-token";
  static String resendOtp() => "/resend-otp";
  static String resetPassword() => "/reset-password";
  static String userProfile() => "/me";
  static String editProfile() => "/update-profile";
  static String updateAvatar() => "/update-avatar";
  static String changePassword() => "/change-password";
  static String logout() => "/logout";
  static String followingList() => "/fan/following";
  static String postFollow(int id) => "/fan/follow/$id";
  static String postUnFollow(int id) => "/fan/unfollow/$id";
  static String getHomeContent() => "/fan/home";
  static String createCelebrityPost() => "/auth/celebrity-posts";
  static String updateCelebrityPost(int id) => "/auth/celebrity-posts/$id";
  static String getCategoryDetails(int id) => "/fan/celebrities/$id";
  static String getCelebrityPackages() => "/celebrity/post";
  static String getLeaderBoard() => "/leaderboard?period=all_time";

  static String deleteAccount() => "/delete-profile";

  static String chatList() => "/fan-celebrity-chat/list";
  static String conversation(int userId) =>
      "/fan-celebrity-chat/conversation/$userId";
  static String sendMessage(int userId) => "/fan-celebrity-chat/send/$userId";
  static String chatRoom(int userId) => "/fan-celebrity-chat/room/$userId";
  static String searchChat(String name) =>
      "/fan-celebrity-chat/search?keyword=$name";

  static String placeOrder() => "/orders";
  static String saveVideo() => "/fan/save-video";
  static String getSaveVideo() => "/fan/saved-videos";
  static String managersList() => "/manager/invitation/list";
  static String deleteManager(int managerId) =>
      "/manager/invitation/remove/$managerId";

  static String professionCategory() => "/category";
  static String refreshToken() => "/refresh-token";
  static String chatPayment(int celebrityId) =>
      "/chat-subscription/subscribe/$celebrityId";

  static String featuredCelebrity() => "/fan/featured";
  static String searchFilter() => "/fan/celebrities/search";
  static String sendInvitation() => "/manager/invitation/send";
  static String sendManagerOtp() => "/manager/auth/request-otp";

  static String acceptOrder(int messageId) =>
      "/fan-celebrity-chat/message/$messageId/accept-order";

  static String postReview(int messageId) =>
      "/fan-celebrity-chat/message/$messageId/submit-review";

  static String verifyManagerOtp() => "/manager/auth/verify-otp";
  static String resendManagerOtp() => "/manager/auth/resend-otp";
  static String getWallet() => "/celebrity/wallet/overview";
  static String getEarnings({String filter = 'all_time'}) =>
      "/celebrity/wallet/earnings?filter=$filter";

  static String getOrders({String? status}) =>
      status != null ? "/orders?status=$status" : "/orders";

  static String categoryByProfession(int id) =>
      "/fan/professions/$id/celebrities";

  static String fancategory() => "/category";
  static String getCelebrityByPrice(int price) =>
      "/fan/home/celebrityByPrice?price_range=$price";


  static String accountConnect() => "/payment/stripe/account/connect";
    static String accountInfo() => "/payment/stripe/account/info";
}
