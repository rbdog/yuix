//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_nav_router.dart';
import 'package:yuix/src/router/yui_router_protocol.dart';
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
  })  : state = (() {
          // init state
          final paths = pages.keys.toList();
          final path = initialPath ?? paths.first;
          return ValueNotifier(path);
        })(),
        initialPath = initialPath ?? pages.keys.toList().first;

  /// selected path
  final ValueNotifier<String> state;

  /// members
  final String initialPath;
  final Map<Path, TabPageBuilder> pages;
  final Map<Path, TabBarItemBuilder>? items;

  /// Tab Page ID
  String get selectedPath => state.value;

  /// selected index
  int get selectedIndex {
    final index = pages.keys.toList().indexWhere(
          (e) => e == selectedPath,
        );
    return index;
  }

  /// Switch Tab
  void select(String path) {
    if (state.value == path) {
      return;
    }
    state.value = path;
  }

  /// Switch Tab by index
  void selectIndex(int index) {
    final path = pages.keys.toList()[index];
    select(path);
  }

  /// reset all state
  void resetAllState() {
    state.value = initialPath;
  }
}
