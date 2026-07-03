// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tc_mcandy/features/Tarms%20&%20Policy/Tarms_screens.dart';
import 'package:tc_mcandy/features/Tarms%20&%20Policy/policy_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/forgot/forgot_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/forgot/forget_verify_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/manager_login/manager_login_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/signin/signin_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/verify_screen/verfiy_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_profile/presentation/widget/celebrity_edit_profile.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/packages/presentation/edit_Packages/edit_packages.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/requests/presentation/celebrity_trofi_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/bank_account/bank_account_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/earn_activity/earn_activity_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/help_desk/help_desk_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/stripe_account_status_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/wallet/presentation/wallet_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/manager_section/presentration/manager_screen.dart';
import 'package:tc_mcandy/features/fan_side/category_details/presentation/category_by_profession_screen.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/show_all_featured_screen.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/show_all_recent_screen.dart';
import 'package:tc_mcandy/features/fan_side/home/presentation/show_all_by_price_screen.dart';
import 'package:tc_mcandy/features/auth/presentation/reset_pass/reset_password_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/celebrity_navber/celebrity_navber.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/identefication/identification_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/identefication/verifi_completed.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/new_order/new_order_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/about_profession.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profession/profession_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profile_complete/profile_complete.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/profile_image_add/presentation/add_profile_image.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/set_packages.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/welcome_profile/welcome_profile.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/account_comfirm_screen.dart';
import 'package:tc_mcandy/features/celebrity%20side/taleny_account/talent_account.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/Order_submitted_screen.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/celebrity_details.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/place_an_order_screen.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/place_order_screen.dart';
import 'package:tc_mcandy/features/fan_side/celebrity_details/presentration/video_screen.dart';
import 'package:tc_mcandy/features/fan_side/change_password/presentation/change_password.dart';
import 'package:tc_mcandy/features/fan_side/message/presentation/inbox_screen.dart';
import 'package:tc_mcandy/features/fan_side/navber_screen.dart';
import 'package:tc_mcandy/features/navigation_screen.dart';
import 'package:tc_mcandy/features/fan_side/notifications/presentation/notification_screen.dart';
import 'package:tc_mcandy/features/onboarding_screens/onboarding_slaid.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/edit_profile_screen.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/my_orders.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/profile_screen.dart';
import 'package:tc_mcandy/features/fan_side/profile/presentation/saved_video_screen.dart';
import 'package:tc_mcandy/features/role/role_screen.dart';
import 'package:tc_mcandy/features/fan_side/order/presentation/order_screen.dart';
import 'package:tc_mcandy/features/fan_side/search/search_screen.dart';

import 'package:tc_mcandy/loading.dart';
import 'package:tc_mcandy/features/fan_side/customer_support/presentation/customer_support_screen.dart';

import '../features/auth/presentation/manager_login/manager_veryfy_otp_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String navigationScreen = '/navigation_screen';
  static const String onboardingSlaid = '/onboardingSlaid';
  static const String signinRoute = '/signin_screen';
  static const String signUpScreen = '/signUpScreen';
  static const String roleScreen = '/roleScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verfiyScreen = '/verfiyScreen';
  static const String forgetVerifyScreen = '/forgetVerifyScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String navberScreen = '/navberScreen';
  static const String athletesScreen = '/athletesScreen';
  static const String categoryDetailsRoute = '/categoryDetailsRoute';
  static const String notificationScreen = '/notificationScreen';
  static const String orderScreen = '/orderScreen';
  static const String chatScreen = '/chatScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String savedVideoScreen = '/savedVideoScreen';
  static const String changePassword = '/changePassword';
  static const String myOrders = '/myOrders';
  static const String searchScreen = '/searchScreen';
  static const String celebrityDetails = '/celebrityDetails';
  static const String placeOrder = '/placeOrder';
  static const String videoScreen = '/videoScreen';
  static const String profileScreen = '/profileScreen';
  static const String placeAnOrderScreen = '/placeAnOrderScreen';
  static const String policyScreen = '/policyScreen';
  static const String tarmsScreens = '/tarmsScreens';
  static const String talentAccount = '/talentAccount';
  static const String accountComfirmScreen = '/accountComfirmScreen';
  static const String welcomeProfile = '/welcomeProfile';
  static const String addProfileImage = '/addProfileImage';
  static const String professionScreen = '/professionScreen';
  static const String aboutProfession = '/aboutProfession';
  static const String setPackages = '/setPackages';
  static const String newOrderScreen = '/newOrderScreen';
  static const String identificationScreen = '/identificationScreen';
  static const String verifiCompleted = '/verifiCompleted';
  static const String profileComplete = '/profileComplete';
  static const String celebrityNavber = '/celebrityNavber';
  static const String celebrityEditProfile = '/celebrityEditProfile';
  static const String celebrityTrofiScreen = '/celebrityTrofiScreen';
  static const String editPackages = '/editPackages';
  static const String walletScreen = '/walletScreen';
  static const String bankAccountScreen = '/bankAccountScreen';
  static const String helpDeskScreen = '/helpDeskScreen';
  static const String earnActivityScreen = '/earnActivityScreen';
  static const String managerScreen = '/managerScreen';
  static const String managerLoginScreen = '/managerLoginScreen';
  static const String managerVeryfyOtpScreen = '/managerVeryfyOtpScreen';
  static const String orderSubmittedScreen = '/orderSubmittedScreen';
  static const String loading = '/loading';
  static const String categoryByProfession = '/categoryByProfession';
  static const String showAllFeatured = '/showAllFeatured';
  static const String showAllRecent = '/showAllRecent';
  static const String showAllByPrice = '/showAllByPrice';

  static const String inboxScreen = '/inboxScreen';
  static const String stripeAccountStatusScreen = '/stripeAccountStatusScreen';

  static const String customerSupportScreen = '/customerSupportScreen';
  static const String testInboxScreen = '/testInboxScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen(),
              );

      case Routes.signinRoute:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: SigninScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => SigninScreen());

      case Routes.loading:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: Loading(), settings: settings)
            : CupertinoPageRoute(builder: (context) => Loading());

      case Routes.stripeAccountStatusScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const StripeAccountStatusScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const StripeAccountStatusScreen(),
              );

      case Routes.signUpScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SignUpScreen(role: args['role'], text: args['text']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    SignUpScreen(role: args['role'], text: args['text']),
              );

      case Routes.onboardingSlaid:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OnboardingSlaid(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const OnboardingSlaid());

      case Routes.roleScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: RoleScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => RoleScreen());

      case Routes.forgotScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ForgotScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ForgotScreen());

      case Routes.verfiyScreen:
        final args = settings.arguments as Map;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VerfiyScreen(roleSelected: args["roleSelected"]),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    VerfiyScreen(roleSelected: args['roleSelected']),
              );

      case Routes.forgetVerifyScreen:
        final forgetArgs = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ForgetVerifyScreen(email: forgetArgs['email']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    ForgetVerifyScreen(email: forgetArgs['email']),
              );

      case Routes.resetPasswordScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ResetPasswordScreen(email: args['email']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ResetPasswordScreen(email: args['email']),
              );

      case Routes.navberScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavberScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const NavberScreen());

      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NotificationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const NotificationScreen(),
              );

      case Routes.orderScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OrderScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const OrderScreen());

      case Routes.inboxScreen:
        final args = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: InboxScreen(
                  id: args?['id'] ?? 0,
                  roomId: args?['roomId'] ?? 0,
                  name: args?['name'] ?? '',
                  image: args?['image'] ?? '',
                  isCelebrity: args?['isCelebrity'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => InboxScreen(
                  id: args?['id'] ?? 0,
                  roomId: args?['roomId'] ?? 0,
                  name: args?['name'] ?? '',
                  image: args?['image'] ?? '',
                  isCelebrity: args?['isCelebrity'] ?? false,
                ),
              );

      case Routes.categoryByProfession:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CategoryByProfessionScreen(
                  title: args['title'],
                  id: args['id'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CategoryByProfessionScreen(
                  title: args['title'],
                  id: args['id'],
                ),
              );

      case Routes.showAllFeatured:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ShowAllFeaturedScreen(title: args['title']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    ShowAllFeaturedScreen(title: args['title']),
              );

      case Routes.showAllRecent:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ShowAllRecentScreen(title: args['title']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ShowAllRecentScreen(title: args['title']),
              );

      case Routes.showAllByPrice:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ShowAllByPriceScreen(
                  title: args['title'],
                  priceRange: args['priceRange'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => ShowAllByPriceScreen(
                  title: args['title'],
                  priceRange: args['priceRange'],
                ),
              );

      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const EditProfileScreen(),
              );

      case Routes.savedVideoScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SavedVideoScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const SavedVideoScreen(),
              );

      case Routes.changePassword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ChangePassword(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ChangePassword());

      case Routes.myOrders:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const MyOrders(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const MyOrders());

      case Routes.searchScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const SearchScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const SearchScreen());

      case Routes.celebrityDetails:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: CelebrityDetails(id: args['id']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => CelebrityDetails(id: args['id']),
              );

      case Routes.placeOrder:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PlaceOrder(id: args['id']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PlaceOrder(id: args['id']),
              );

      case Routes.videoScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: VideoScreen(
                  videoUrl: args['video_url'],
                  id: args['id'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    VideoScreen(videoUrl: args['video_url'], id: args['id']),
              );

      case Routes.profileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ProfileScreen());

      case Routes.placeAnOrderScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PlaceAnOrderScreen(
                  amount: args['amount'],
                  packageId: args['packageId'],
                  packageName: args['packageName'],
                  packageDetails: args['packageDetails'],
                  revisions: args['revisions'],
                  deliveryDays: args['deliveryDays'],
                  editable: args['editable'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => PlaceAnOrderScreen(
                  amount: args['amount'],
                  packageId: args['packageId'],
                  packageName: args['packageName'],
                  packageDetails: args['packageDetails'],
                  revisions: args['revisions'],
                  deliveryDays: args['deliveryDays'],
                  editable: args['editable'],
                ),
              );

      case Routes.policyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const PolicyScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const PolicyScreen());

      case Routes.tarmsScreens:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const TarmsScreens(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const TarmsScreens());

      case Routes.talentAccount:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const TalentAccount(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const TalentAccount());

      case Routes.accountComfirmScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AccountComfirmScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const AccountComfirmScreen(),
              );

      case Routes.welcomeProfile:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const WelcomeProfile(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const WelcomeProfile());

      case Routes.addProfileImage:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AddProfileImage(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const AddProfileImage());

      case Routes.professionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProfessionScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const ProfessionScreen(),
              );

      case Routes.aboutProfession:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const AboutProfession(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const AboutProfession());

      case Routes.setPackages:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SetPackages(
                  celebrityBio: args['celebrityBio'],
                  videoCategory: args['videoCategory'],
                  serviceTags: args['serviceTags'],
                ),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => SetPackages(
                  celebrityBio: args['celebrityBio'],
                  videoCategory: args['videoCategory'],
                  serviceTags: args['serviceTags'],
                ),
              );

      case Routes.newOrderScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NewOrderScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const NewOrderScreen());

      case Routes.identificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const IdentificationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const IdentificationScreen(),
              );

      case Routes.verifiCompleted:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const VerifiCompleted(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const VerifiCompleted());

      case Routes.profileComplete:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ProfileComplete(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ProfileComplete());

      case Routes.celebrityNavber:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CelebrityNavber(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const CelebrityNavber());

      case Routes.celebrityEditProfile:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CelebrityEditProfile(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CelebrityEditProfile(),
              );

      case Routes.celebrityTrofiScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CelebrityTrofiScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CelebrityTrofiScreen(),
              );

      case Routes.editPackages:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EditPackages(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const EditPackages());

      case Routes.walletScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const WalletScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const WalletScreen());

      case Routes.bankAccountScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const BankAccountScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const BankAccountScreen(),
              );

      case Routes.helpDeskScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HelpDeskScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const HelpDeskScreen());

      case Routes.earnActivityScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const EarnActivityScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const EarnActivityScreen(),
              );

      case Routes.managerScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ManagerScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => const ManagerScreen());

      case Routes.managerLoginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ManagerLoginScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const ManagerLoginScreen(),
              );

      case Routes.managerVeryfyOtpScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ManagerVeryfyOtpScreen(email: args['email']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    ManagerVeryfyOtpScreen(email: args['email']),
              );

      case Routes.orderSubmittedScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const OrderSubmittedScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const OrderSubmittedScreen(),
              );

      case Routes.customerSupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CustomerSupportScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => const CustomerSupportScreen(),
              );

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
                child: child,
              );
            },
      );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
