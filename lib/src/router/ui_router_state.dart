//
//
//

import 'package:yui_kit/src/router/ui_task.dart';
import 'package:yui_kit/src/router/ui_route.dart';

/// UiRouterState
class UiRouterState {
  final List<UiRoute> pageRoutes;
  final List<UiRoute> dialogRoutes;
  final List<UiTask> tasks;

  UiRouterState({
    required this.pageRoutes,
    required this.dialogRoutes,
    required this.tasks,
  });
}
