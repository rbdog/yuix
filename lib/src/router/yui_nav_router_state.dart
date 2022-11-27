//
//
//

import 'package:yuix/src/router/yui_page_state.dart';
import 'package:yuix/src/router/yui_dialog_state.dart';
import 'package:yuix/src/router/yui_task.dart';

/// YuiNavRouterState
class YuiNavRouterState {
  final List<YuiPageState> pageStates;
  final List<YuiDialogState> dialogStates;
  final List<YuiTask> tasks;
  final bool drawerIsOpen;

  YuiNavRouterState({
    required this.pageStates,
    required this.dialogStates,
    required this.tasks,
    required this.drawerIsOpen,
  });
}
