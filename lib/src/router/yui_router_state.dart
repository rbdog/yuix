//
//
//

import 'package:yuix/src/router/yui_task.dart';
import 'package:yuix/src/router/yui_route.dart';

/// YuiRouterState
class YuiRouterState {
  final List<YuiRoute> pageRoutes;
  final List<YuiRoute> dialogRoutes;
  final List<YuiTask> tasks;

  YuiRouterState({
    required this.pageRoutes,
    required this.dialogRoutes,
    required this.tasks,
  });
}
