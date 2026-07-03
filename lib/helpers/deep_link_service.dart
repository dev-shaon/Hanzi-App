import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:tc_mcandy/helpers/navigation_service.dart';
import '../helpers/all_routes.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> init() async {
    _appLinks = AppLinks();

    // Handle links when the app is already open
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });

    // Check for initial link if the app was started by one
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      // Handle error if necessary
    }
  }

  void _handleDeepLink(Uri uri) {
    // Example URI: tcmcandy://celebrity?id=123
    if (uri.scheme == 'tcmcandy') {
      if (uri.host == 'celebrity') {
        final idStr = uri.queryParameters['id'];
        if (idStr != null) {
          final id = int.tryParse(idStr);
          if (id != null) {
            _navigateToCelebrity(id);
          }
        }
      }
    }
  }

  void _navigateToCelebrity(int id) {
    // We use NavigationService to navigate from anywhere
    NavigationService.navigateToWithArgs(
      Routes.celebrityDetails,
      {'id': id},
    );
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}
