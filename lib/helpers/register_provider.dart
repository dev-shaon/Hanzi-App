// import 'package:kabirumar/provider/verification_masjid_provider.dart';
import 'package:provider/provider.dart';
import 'package:tc_mcandy/providers/auth_provider.dart';
import 'package:tc_mcandy/providers/chat_provider.dart';

var providers = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
];