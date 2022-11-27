//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_nav_router.dart';
import 'package:yuix/src/router/yui_router_protocol.dart';
import 'package:yuix/src/router/yui_tab_route_state.dart';
import 'package:yuix/src/router/yui_tab_state.dart';

/// TabPageBuilder
typedef TabPageBuilder = Widget Function(YuiTabState state);

/// TabBarItemBuilder
typedef TabBarItemBuilder = Widget Function(YuiTabState state);

/// Router for Tab Pages
class YuiTabRouter implements YuiRouterProtocol {
  YuiTabRouter({
    String? initialPath,
    required this.pages,
    this.items,
    this.drawer,
  })  : state = (() {
          // init state
          final paths = pages.keys.toList();
          final path = initialPath ?? paths.first;
          final state = YuiTabRouterState(
            path: path,
            drawerIsOpen: false,
          );
          return ValueNotifier(state);
        })(),
        initialPath = initialPath ?? pages.keys.toList().first;

  /// selected path
  final ValueNotifier<YuiTabRouterState> state;

  /// members
  final String initialPath;
  final Map<Path, TabPageBuilder> pages;
  final Map<Path, TabBarItemBuilder>? items;
  final Widget Function()? drawer;

  final drawerKey = GlobalKey<ScaffoldState>();

  /// Tab Page ID
  String get selectedPath => state.value.path;

  /// selected index
  int get selectedIndex {
    final index = pages.keys.toList().indexWhere(
          (e) => e == selectedPath,
        );
    return index;
  }

  /// Switch Tab
  void select(String path) {
    if (state.value.path == path) {
      return;
    }
    state.value = YuiTabRouterState(
      path: path,
      drawerIsOpen: state.value.drawerIsOpen,
    );
  }

  /// Switch Tab by index
  void selectIndex(int index) {
    final path = pages.keys.toList()[index];
    select(path);
  }

  /// drawer in
  void slideIn() {
    // state
    final newState = YuiTabRouterState(
      path: state.value.path,
      drawerIsOpen: true,
    );
    state.value = newState;
    // controll byself
    drawerKey.currentState?.openDrawer();
  }

  /// drawer out
  void slideOut() {
    // state
    final newState = YuiTabRouterState(
      path: state.value.path,
      drawerIsOpen: false,
    );
    state.value = newState;
    // controll byself
    drawerKey.currentState?.closeDrawer();
  }

  /// reset all state
  void resetAllState() {
    state.value = YuiTabRouterState(
      path: initialPath,
      drawerIsOpen: false,
    );
  }
}
