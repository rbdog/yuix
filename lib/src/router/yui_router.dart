//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/path2pattern_params.dart';
import 'package:yuix/src/router/yui_dialog_state.dart';
import 'package:yuix/src/router/yui_page_state.dart';
import 'package:yuix/src/router/yui_router_protocol.dart';
import 'package:yuix/src/router/yui_nav_router_state.dart';
import 'package:yuix/src/router/yui_task.dart';

// Path
typedef Path = String;

/// a Page
typedef PageBuilder = Widget Function(YuiPageState state);

/// a Dialog
typedef DialogBuilder = Widget Function(YuiDialogState state);

/// Nav Router
class YuiRouter implements YuiRouterProtocol {
  /// Constructor
  YuiRouter({
    String? initialPath,
    required this.pages,
    this.dialogs = const {},
  })  : state = (() {
          // init state
          final path = initialPath ?? pages.keys.first;
          final state = _createState(
            path: path,
            pages: pages,
          );
          return ValueNotifier(state);
        })(),
        initialPath = initialPath ?? pages.keys.first;

  final Path initialPath;
  final Map<Path, PageBuilder> pages;
  final Map<Path, DialogBuilder> dialogs;
  final ValueNotifier<YuiNavRouterState> state;

  static YuiNavRouterState _createState({
    required String path,
    required Map<Path, PageBuilder> pages,
  }) {
    final patternParams = path2PatternParams(
      path,
      pages.keys.toList(),
    );
    if (patternParams == null) {
      throw Exception('Not found page for $path');
    }
    final pageState = YuiPageState(
      pattern: patternParams.pattern,
      path: path,
      params: patternParams.params,
    );
    return YuiNavRouterState(
      pageStates: [pageState],
      dialogStates: [],
      tasks: [],
    );
  }

  /// Go to the next page
  void push(String path) {
    final patternParams = path2PatternParams(
      path,
      pages.keys.toList(),
    );
    if (patternParams == null) {
      throw Exception('Not found page for $path');
    }
    final pageState = YuiPageState(
      pattern: patternParams.pattern,
      path: path,
      params: patternParams.params,
    );
    final newState = YuiNavRouterState(
      pageStates: [...state.value.pageStates, pageState],
      dialogStates: state.value.dialogStates,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// Back page (until: pattern)
  void pop({String? until}) {
    if (state.value.pageStates.length <= 1) return;
    final patternToPop = until ??
        state.value.pageStates[state.value.pageStates.length - 2].pattern;
    final index =
        state.value.pageStates.indexWhere((e) => e.pattern == patternToPop);
    if (index < 0) return;
    final newStack = state.value.pageStates.sublist(0, index + 1);
    final newState = YuiNavRouterState(
      pageStates: newStack,
      dialogStates: state.value.dialogStates,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// current path stack
  List<String> get pathStack {
    final paths = state.value.pageStates.map((e) => e.path).toList();
    return paths;
  }

  /// reset all state
  void resetAllState() {
    state.value = _createState(
      path: initialPath,
      pages: pages,
    );
  }

  /// Open dialog
  YuiDialogState open(String path) {
    final patternParams = path2PatternParams(
      path,
      dialogs.keys.toList(),
    );
    if (patternParams == null) {
      throw Exception('Not found dialog for $path');
    }
    final dialogState = YuiDialogState(
      pattern: patternParams.pattern,
      path: path,
      params: patternParams.params,
    );
    final newState = YuiNavRouterState(
      pageStates: state.value.pageStates,
      dialogStates: [...state.value.dialogStates, dialogState],
      tasks: state.value.tasks,
    );
    state.value = newState;
    return dialogState;
  }

  /// Close dialog
  void close(YuiDialogState dialogState) {
    dialogState.call.dispose();
    if (state.value.dialogStates.isEmpty) return;
    final removeIndex =
        state.value.dialogStates.indexWhere((e) => e.path == dialogState.path);
    final newRoutes = state.value.dialogStates..removeAt(removeIndex);
    final newState = YuiNavRouterState(
      pageStates: state.value.pageStates,
      dialogStates: newRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// Show loading with a task
  Future<void> loading({
    required String label,
    required Function() task,
  }) async {
    final loadingTask = YuiTask(label: label, action: task);
    final prevState = YuiNavRouterState(
      pageStates: state.value.pageStates,
      dialogStates: state.value.dialogStates,
      tasks: [...state.value.tasks, loadingTask],
    );
    state.value = prevState;
    // await task action
    await loadingTask.action();
    final nextState = YuiNavRouterState(
      pageStates: state.value.pageStates,
      dialogStates: state.value.dialogStates,
      tasks: state.value.tasks..remove(loadingTask),
    );
    state.value = nextState;
  }
}
