//
//
//

import 'package:yuix/src/utils/cron_center.dart';
import 'package:yuix/src/utils/event_center.dart';
import 'package:yuix/src/utils/lifecycle.dart';

class AppCycle {
  final lifecycle = Lifecycle();
  final eventCenter = EventCenter();
  final cronCenter = CronCenter();

  AppCycle();
}
