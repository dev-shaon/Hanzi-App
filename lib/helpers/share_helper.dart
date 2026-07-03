import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;
import 'package:tc_mcandy/helpers/loading_helper.dart';

class ShareHelper {
  static Future<void> shareVideo({
    required String videoUrl,
    String? text,
    String? subject,
  }) async {
    try {
      String filePath;

      if (videoUrl.startsWith('http')) {
        final directory = await getTemporaryDirectory();
        final fileName = p.basename(Uri.parse(videoUrl).path);
        final extension = p.extension(fileName).isEmpty ? '.mp4' : p.extension(fileName);
        final baseName = p.basenameWithoutExtension(fileName);
        filePath = '${directory.path}/$baseName$extension';

        final file = File(filePath);
        if (!await file.exists()) {
          final dio = Dio();
          await dio.download(videoUrl, filePath).waitingForSucess();
        }
      } else {
        filePath = videoUrl;
      }

final xFile = XFile(filePath);
      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: text,
          subject: subject,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> shareProfile({
    required int id,
    required String name,
    String? profession,
  }) async {
    try {
      final String deepLink = "tcmcandy://celebrity?id=$id";
      String text =
          "Check out $name${profession != null ? " ($profession)" : ""} on HanZi MCandy!";
      
      text += "\n\nOpen in app: $deepLink";

      await SharePlus.instance.share(
        ShareParams(text: text),
      );
    } catch (e) {
      rethrow;
    }
  }
}
