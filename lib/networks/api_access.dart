import 'package:rxdart/rxdart.dart';
import 'package:tc_mcandy/features/auth/data/rx_forget_email_send/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_manager_resend_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_send_manager_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_signup_get_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_talent_profile/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_verify_manager_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_verify_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/verify_forget_otp/rx.dart';
import 'package:tc_mcandy/features/auth/data/rx_reset_pass/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_profile/data/get_celebrity_profile/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/data/get_celebrity_package/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/data/post_edited_package/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/model/celebrity_package_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/data/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/model/celebrity_order_list_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/data/rx_get_wallet/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/data/rx_get_earnings/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/data/rx_account_connect/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/wallet_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/earnings_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/account_connect.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/data/rx_get_account_info/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/model/account_info_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/data/get_profession_category/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/model/profession_category_model/profession_category_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/data/create_celebrity_post/rx.dart';
import 'package:tc_mcandy/features/fan_side/category_details/data/get_profession_by_category/rx.dart';
import 'package:tc_mcandy/features/fan_side/category_details/data/search_filer/rx.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/categories_by_profession_model.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/search_filter_model.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/data/rx_place_order/rx.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/data/rx_chat_payment/rx.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/data/rx_save_video/rx.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/data/get_leaderboard/rx.dart';
import 'package:tc_mcandy/features/fan_side/leaderboard/model/leaderboard_model.dart';
import 'package:tc_mcandy/features/fan_side/message/data/accept_delivery/rx.dart';
import 'package:tc_mcandy/features/fan_side/message/data/post_review/rx.dart';
import 'package:tc_mcandy/features/fan_side/message/data/get_chat_list/rx.dart';
import 'package:tc_mcandy/features/fan_side/message/model/chat_list_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_edit_profile/rx.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_profile/model/celebrity_profile_model.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profile_image_add/data/rx_update_avatar/rx.dart';
import 'package:tc_mcandy/features/fan_side/category_details/data/get_caategory_rx/rx.dart';
import 'package:tc_mcandy/features/fan_side/category_details/model/categories_model.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/data/rx_get_celebrity_details/rx.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/data/rx_post_follow/rx.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/model/celebrity_details_model.dart';
import 'package:tc_mcandy/features/fan_side/change_password/data/rx_change_password/rx.dart';
import 'package:tc_mcandy/features/fan_side/following/data/rx_following_list/rx.dart';
import 'package:tc_mcandy/features/fan_side/following/data/rx_post_unfollow/rx.dart';
import 'package:tc_mcandy/features/fan_side/following/model/fan_follower_model.dart';
import 'package:tc_mcandy/features/fan_side/home/data/rx_get_home_content/rx.dart';
import 'package:tc_mcandy/features/fan_side/home/data/get_featured_celebrity/rx.dart';
import 'package:tc_mcandy/features/fan_side/home/data/get_celebrity_by_price/rx.dart';
import 'package:tc_mcandy/features/fan_side/home/model/featured_celebrity_model.dart'
    as featured_model;
import 'package:tc_mcandy/features/fan_side/home/model/home_content_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_delete_account/rx.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_get_order/rx.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_get_save_video/rx.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_get_user_profile/rx.dart';
import 'package:tc_mcandy/features/fan_side/profile/data/rx_logout/rx.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/my_order_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/profile_model.dart';
import 'package:tc_mcandy/features/fan_side/profile/model/save_video_model.dart';
import 'package:tc_mcandy/features/settings/data/rx_logout/rx.dart';
import '../features/celebrity side/manager_section/data/rx_manager_invitation/rx.dart';
import '../features/celebrity side/manager_section/data/get_managers/rx.dart';
import '../features/celebrity side/manager_section/data/delete_manager/rx.dart';
import '../features/celebrity side/manager_section/model/ManagerListModel.dart';

import '../features/auth/data/rx_login/rx.dart';
import '../features/auth/data/rx_signup/rx.dart';
import '../features/fan_side/message/data/rx_get_inbox/rx.dart';
import '../features/fan_side/message/data/rx_send_message/rx.dart';
import '../features/fan_side/message/model/inbox_response_model.dart';

PostSignUpRx signupRx = PostSignUpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostLoginRx loginRx = PostLoginRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

LogoutRx logoutRx = LogoutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostSignUpGetOtpRx postSignUpGetOtpRx = PostSignUpGetOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostVerifyOtpRx postVerifyOtpRx = PostVerifyOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostTalentProfileRx postTalentProfileRx = PostTalentProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetCategoriesRx getCategoriesRxObj = GetCategoriesRx(
  empty: CategoriesModel(),
  dataFetcher: BehaviorSubject<CategoriesModel>(),
);

GetUserProfileRx getUserProfileRxObj = GetUserProfileRx(
  empty: ProfileModel(),
  dataFetcher: BehaviorSubject<ProfileModel>(),
);

PostLogoutRx postLogoutRxObj = PostLogoutRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetCelebrityProfileRx getCelebrityProfileRxObj = GetCelebrityProfileRx(
  empty: CelebrityProfileModel(),
  dataFetcher: BehaviorSubject<CelebrityProfileModel>(),
);

DeleteAccountRx deleteAccountRxObj = DeleteAccountRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostChangePasswordRx postChangePasswordRxObj = PostChangePasswordRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

EditProfileRx updateProfileRxObj = EditProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetChatListRx getChatListRxObj = GetChatListRx(
  empty: ChatListModel(),
  dataFetcher: BehaviorSubject<ChatListModel>(),
);

PostUpdateAvatarRx updateAvatarRxObj = PostUpdateAvatarRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetFollowingListRx getFollowingListRxObj = GetFollowingListRx(
  empty: FanFollowerModel(),
  dataFetcher: BehaviorSubject<FanFollowerModel>(),
);

PostUnFollowRx postUnFollowRxObj = PostUnFollowRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetHomeContentRx getHomeContentRxObj = GetHomeContentRx(
  empty: HomeContentModel(),
  dataFetcher: BehaviorSubject<HomeContentModel>(),
);

GetFeaturedCelebrityRx getFeaturedCelebrityRxObj = GetFeaturedCelebrityRx(
  empty: featured_model.FeaturedCelebrityModel(),
  dataFetcher: BehaviorSubject<featured_model.FeaturedCelebrityModel>(),
);

GetCelebrityByPriceRx getCelebrityByPriceRxObj = GetCelebrityByPriceRx(
  empty: featured_model.FeaturedCelebrityModel(),
  dataFetcher: BehaviorSubject<featured_model.FeaturedCelebrityModel>(),
);

GetCelebrityDetailsRx getCelebrityDetailsRxObj = GetCelebrityDetailsRx(
  empty: CelebrityDetailsModel(),
  dataFetcher: BehaviorSubject<CelebrityDetailsModel>(),
);

GetProfessionCategoryRx getProfessionCategoryRx = GetProfessionCategoryRx(
  empty: ProfessionCategoryModel(),
  dataFetcher: BehaviorSubject<ProfessionCategoryModel>(),
);

PostFollowRx postFollowRxObj = PostFollowRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

CelebrityPostRx celebrityPostRxObj = CelebrityPostRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetCelebrityPackageRx getCelebrityPackageRxObj = GetCelebrityPackageRx(
  empty: CelebrityPackageModel(),
  dataFetcher: BehaviorSubject<CelebrityPackageModel>(),
);

GetLeaderBoardRx getLeaderBoardRxObj = GetLeaderBoardRx(
  empty: LeaderBoardModel(),
  dataFetcher: BehaviorSubject<LeaderBoardModel>(),
);

EditedCelebrityPackageRx editedCelebrityPackageRxObj = EditedCelebrityPackageRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostPlaceOrderRx postPlaceOrderRxObj = PostPlaceOrderRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostChatPaymentRx postChatPaymentRxObj = PostChatPaymentRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostSaveVideoRx postSaveVideoRxObj = PostSaveVideoRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetSaveVideoRx getSaveVideoRxObj = GetSaveVideoRx(
  empty: SaveVideosModel(),
  dataFetcher: BehaviorSubject<SaveVideosModel>(),
);

GetMyOrderRx getMyOrderRxObj = GetMyOrderRx(
  empty: MyOrderModel(),
  dataFetcher: BehaviorSubject<MyOrderModel>(),
);

GetCategoryByProfessionRx getCategoryByProfessionRxObj =
    GetCategoryByProfessionRx(
      empty: CategoryByProfessionModel(),
      dataFetcher: BehaviorSubject<CategoryByProfessionModel>(),
    );

GetSearchFilterRx getSearchFilterRxObj = GetSearchFilterRx(
  empty: SearchFilterModel(),
  dataFetcher: BehaviorSubject<SearchFilterModel>(),
);

GetCelebrityOrderRx getCelebrityOrderRxObj = GetCelebrityOrderRx(
  empty: CelebrityOrderListModel(),
  dataFetcher: BehaviorSubject<CelebrityOrderListModel>(),
);

PostSendInvitationRx postSendInvitationRx = PostSendInvitationRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetManagerListRx getManagerListRxObj = GetManagerListRx(
  empty: ManagerListModel(),
  dataFetcher: BehaviorSubject<ManagerListModel>(),
);

PostDeleteManagerRx postDeleteManagerRxObj = PostDeleteManagerRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostSendManagerOtpRx postSendManagerOtpRx = PostSendManagerOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostManagerResendOtpRx postManagerResendOtpRx = PostManagerResendOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostVerifyManagerOtpRx postManagerVeryfyOtpRx = PostVerifyManagerOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostForgetEmailSendRx postForgetEmailSendRxObj = PostForgetEmailSendRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

VerifyForgetPassRx verifyForgetPassRxObj = VerifyForgetPassRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostResetPassRx postResetPassRxObj = PostResetPassRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetWalletRx getWalletRxObj = GetWalletRx(
  empty: WalletModel(),
  dataFetcher: BehaviorSubject<WalletModel>(),
);

GetEarningsRx getEarningsRxObj = GetEarningsRx(
  empty: EarningsModel(),
  dataFetcher: BehaviorSubject<EarningsModel>(),
);

GetAccountConnectRx getAccountConnectRxObj = GetAccountConnectRx(
  empty: AccountConnectModel(),
  dataFetcher: BehaviorSubject<AccountConnectModel>(),
);

GetAccountInfoRx getAccountInfoRxObj = GetAccountInfoRx(
  empty: AccountInfoModel(),
  dataFetcher: BehaviorSubject<AccountInfoModel>(),
);

GetInboxMessageRx getInboxMessageRx = GetInboxMessageRx(
  empty: InboxResponseModel(),
  dataFetcher: BehaviorSubject<InboxResponseModel>(),
);

SendMessageRx sendMessageRxObj = SendMessageRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostAcceptOrderRx postAcceptOrderRx = PostAcceptOrderRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostReviewRx postReviewRx = PostReviewRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

