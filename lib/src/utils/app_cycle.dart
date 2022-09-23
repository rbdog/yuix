//
//
//

import 'package:yui_kit/src/utils/cron_center.dart';
import 'package:yui_kit/src/utils/event_center.dart';
import 'package:yui_kit/src/utils/lifecycle.dart';

class AppCycle {
  final lifecycle = Lifecycle();
  final eventCenter = EventCenter();
  final cronCenter = CronCenter();

  AppCycle();
}
