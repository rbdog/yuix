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

  YuiNavRouterState({
    required this.pageStates,
    required this.dialogStates,
    required this.tasks,
  });
}
