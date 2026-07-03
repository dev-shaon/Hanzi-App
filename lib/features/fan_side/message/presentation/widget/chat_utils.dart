import 'dart:math';
import 'package:intl/intl.dart';

String generateDownloadKey() {
  final rng = Random.secure();
  return List.generate(6, (_) => rng.nextInt(10).toString()).join();
}

bool isDifferentDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return true;
  final localA = a.toLocal();
  final localB = b.toLocal();
  return localA.year != localB.year ||
      localA.month != localB.month ||
      localA.day != localB.day;
}

String formatDateSeparator(DateTime dt) {
  final localDt = dt.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final dateToCheck = DateTime(localDt.year, localDt.month, localDt.day);

  String dayLabel;
  if (dateToCheck == today) {
    dayLabel = 'TODAY';
  } else if (dateToCheck == yesterday) {
    dayLabel = 'YESTERDAY';
  } else {
    dayLabel = DateFormat('MMM d').format(localDt).toUpperCase();
  }

  return '$dayLabel AT ${DateFormat('h:mm a').format(localDt)}';
}

String formatBubbleTime(DateTime? dt) {
  if (dt == null) return '';
  return DateFormat('h:mm a').format(dt.toLocal()).toLowerCase();
}

bool isVideoUrl(String? url) {
  if (url == null) return false;
  final l = url.toLowerCase();
  return l.endsWith('.mp4') || l.endsWith('.mov') || l.endsWith('.mkv');
}
