//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/path2route.dart';
import 'package:yuix/src/router/yui_router_state.dart';
import 'package:yuix/src/router/yui_task.dart';
import 'package:yuix/src/router/yui_call.dart';

// Path
typedef Path = String;

/// a Page
typedef PageBuilder = Widget Function(Map<String, String> params);

/// a Dialog
typedef DialogBuilder = Widget Function(YuiCall call);

/// Router for App UI
class YuiRouter {
  final Path rootPath;
  final Map<Path, PageBuilder> pages;
  final Map<Path, DialogBuilder> dialogs;
  final ValueNotifier<YuiRouterState> state;

  /// Constructor
  YuiRouter({
    this.rootPath = '/',
    required this.pages,
    this.dialogs = const {},
  }) : state = (() {
          // init state
          var rootRoute = path2route(
            rootPath,
            pages.keys.toList(),
            false,
          );
          rootRoute ??= path2route(
            pages.keys.first,
            [pages.keys.first],
            false,
          )!;
          return ValueNotifier(
            YuiRouterState(
              pageRoutes: [rootRoute],
              dialogRoutes: [],
              tasks: [],
            ),
          );
        })();

  /// Go to the next page
  void push(String path) {
    final route = path2route(
      path,
      pages.keys.toList(),
      false,
    )!;
    final newState = YuiRouterState(
      pageRoutes: [...state.value.pageRoutes, route],
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// Back page (until: pattern)
  void pop({String? until}) {
    if (state.value.pageRoutes.length <= 1) return;
    final patternToPop = until ??
        state.value.pageRoutes[state.value.pageRoutes.length - 2].pattern;
    final index =
        state.value.pageRoutes.indexWhere((e) => e.pattern == patternToPop);
    if (index < 0) return;
    final newStack = state.value.pageRoutes.sublist(0, index + 1);
    final newState = YuiRouterState(
      pageRoutes: newStack,
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks,
    );
    state.value = newState;
  }

  /// current path stack
  List<String> get pathStack {
    final paths = state.value.pageRoutes.map((e) => e.path).toList();
    return paths;
  }

  /// Open dialog
  YuiCall open(String path) {
    final route = path2route(
      path,
      dialogs.keys.toList(),
      true,
    )!;

    final newState = YuiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: [...state.value.dialogRoutes, route],
      tasks: state.value.tasks,
    );
    state.value = newState;
    return route.call!;
  }

  /// Close dialog
  void close(YuiCall call) {
    call.dispose();
    if (state.value.dialogRoutes.isEmpty) return;
    final removeIndex =
        state.value.dialogRoutes.indexWhere((e) => e.call == call);
    final newRoutes = state.value.dialogRoutes..removeAt(removeIndex);
    final newState = YuiRouterState(
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
    final loadingTask = YuiTask(label: label, action: task);
    final preState = YuiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: state.value.dialogRoutes,
      tasks: [...state.value.tasks, loadingTask],
    );
    state.value = preState;
    // await task action
    await loadingTask.action();
    final postState = YuiRouterState(
      pageRoutes: state.value.pageRoutes,
      dialogRoutes: state.value.dialogRoutes,
      tasks: state.value.tasks..remove(loadingTask),
    );
    state.value = postState;
  }
}
