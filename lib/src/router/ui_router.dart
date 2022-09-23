//
//
//

import 'package:flutter/material.dart';
import 'package:yui_kit/src/router/real_path_to_route.dart';
import 'package:yui_kit/src/router/ui_router_state.dart';
import 'package:yui_kit/src/router/ui_task.dart';
import 'package:yui_kit/src/router/ui_call.dart';

// Path
typedef Path = String;

/// a Page
typedef UiPage = Widget Function(Map<String, String> params);

/// a Dialog
typedef UiDialog = Widget Function(UiCall call);

/// Router for App UI
class UiRouter {
  final Path rootPath;
  final Map<Path, UiPage> pages;
  final Map<Path, UiDialog> dialogs;
  final ValueNotifier<UiRouterState> state;

  /// Constructor
  UiRouter({
    this.rootPath = '/',
    required this.pages,
    this.dialogs = const {},
  }) : state = (() {
          // init state
          var rootRoute = realPathToRoute(
            rootPath,
            pages.keys.toList(),
            false,
          );
          rootRoute ??= realPathToRoute(
            pages.keys.first,
            [pages.keys.first],
            false,
          )!;
          return ValueNotifier(
            UiRouterState(
              pageRoutes: [rootRoute],
              dialogRoutes: [],
              tasks: [],
            ),
          );
        })();

  /// Go to the next page
  void push(String realPath) {
    final route = realPathToRoute(
      realPath,
      pages.keys.toList(),
      false,
    )!;
    final newState = UiRouterState(
      pageRoutes: [...state.value.pageRoutes, route],
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// Back page (until: patternPath)
  void pop({String? until}) {
    if (state.value.pageRoutes.length <= 1) return;
    final patternPathToPop = until ??
        state.value.pageRoutes[state.value.pageRoutes.length - 2].patternPath;
    final index = state.value.pageRoutes
        .indexWhere((e) => e.patternPath == patternPathToPop);
    if (index < 0) return;
    final newStack = state.value.pageRoutes.sublist(0, index + 1);
    final newState = UiRouterState(
      pageRoutes: newStack,
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// current path stack
  List<String> get pathStack {
    final realPathList = state.value.pageRoutes.map((e) => e.realPath).toList();
    return realPathList;
  }

  /// Open dialog
  UiCall open(String path) {
    final route = realPathToRoute(
      path,
      dialogs.keys.toList(),
      true,
    )!;

    final newState = UiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: [...state.value.dialogRoutes, route],
      tasks: state.value.tasks,
    );
    state.value = newState;
    return route.call!;
  }

  /// Close dialog
  void close(UiCall call) {
    call.dispose();
    if (state.value.dialogRoutes.isEmpty) return;
    final removeIndex =
        state.value.dialogRoutes.indexWhere((e) => e.call == call);
    final newRoutes = state.value.dialogRoutes..removeAt(removeIndex);
    final newState = UiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: newRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// Show loading with a task
  Future<void> loading({
    required String label,
    required Function() task,
  }) async {
    final loadingTask = UiTask(label: label, action: task);
    final preState = UiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: state.value.dialogRoutes,
      tasks: [...state.value.tasks, loadingTask],
    );
    state.value = preState;
    // await task action
    await loadingTask.action();
    final postState = UiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks..remove(loadingTask),
    );
    state.value = postState;
  }
}
