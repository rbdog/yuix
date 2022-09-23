import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  // datetime の復元
  // final dateTime = DateTime.parse(createdAt).toLocal();

  String format(String format) {
    return DateFormat(format).format(this);
  }

  static DateTime fromYyyyMMdd({required int yyyyMMdd}) {
    final str = yyyyMMdd.toString();
    final yyyy = int.parse(str.substring(0, 4));
    final mm = int.parse(str.substring(4, 6));
    final dd = int.parse(str.substring(6, 8));
    DateTime dateTime = DateTime(yyyy, mm, dd);
    return dateTime;
  }

  String snsFormat({
    String? secAgo = '秒前',
    String? minutesAgo = '分前',
    String? hoursAgo = '時間前',
    String? yesterday = '昨日',
    String baseFormat = 'yyyy/MM/dd',
  }) {
    final Duration difference = DateTime.now().difference(this);
    final int diffSec = difference.inSeconds;

    if (diffSec < 60) {
      if (secAgo != null) {
        return '$diffSec $secAgo';
      }
    } else if (diffSec < 60 * 60) {
      if (minutesAgo != null) {
        return difference.inMinutes.toString() + minutesAgo;
      }
    } else if (diffSec < 60 * 60 * 24) {
      if (hoursAgo != null) {
        return difference.inHours.toString() + hoursAgo;
      }
    } else if (diffSec < 60 * 60 * 24 * 2) {
      if (yesterday != null) {
        return yesterday;
      }
    }

    return format(baseFormat);
  }

  String deadlineFormat({
    String sec = '秒',
    String minutes = '分',
    String hours = '時間',
    String day = '日',
    String baseFormat = 'yyyy/MM/dd',
    DateTime? from,
  }) {
    final now = from == null ? from! : DateTime.now();
    final Duration difference = this.difference(now);
    final int diffSec = difference.inSeconds;

    final D = diffSec ~/ (60 * 60 * 24);
    final modD = diffSec % (60 * 60 * 24);
    final H = modD ~/ (60 * 60);
    final modH = modD % (60 * 60);
    final M = modH ~/ (60);
    final S = modH % (60);

    if (D > 0) {
      return '$D $day $H $hours';
    } else if (H > 0) {
      return '$H $hours $M $minutes $S $sec';
    } else {
      return '$M $minutes $S $sec';
    }
  }
}
