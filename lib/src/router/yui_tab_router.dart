//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_router.dart';
import 'package:yuix/src/router/yui_router_protocol.dart';
import 'package:yuix/src/router/yui_tab_state.dart';
import 'package:yuix/src/router/yui_tab_edge.dart';
import 'package:yuix/src/views/yui_tab_bar_style.dart';

typedef TabPageBuilder = Widget Function(YuiTabState state);
typedef TabBarItemBuilder = Widget Function(YuiTabState state);

/// Router for Tab Pages
class YuiTabRouter implements YuiRouterProtocol {
  YuiTabRouter({
    String? initialPath,
    required this.pages,
    this.items,
    this.edge = YuiTabEdge.bottom,
    YuiTabBarStyle? tabBarStyle,
  })  : state = (() {
          // init state
          final paths = pages.keys.toList();
          final path = initialPath ?? paths.first;
          return ValueNotifier(path);
        })(),
        initialPath = initialPath ?? pages.keys.toList().first,
        tabBarStyle = tabBarStyle ?? YuiTabBarStyle();

  /// selected path
  final ValueNotifier<String> state;

  /// members
  final String initialPath;
  final Map<Path, TabPageBuilder> pages;
  final Map<Path, TabBarItemBuilder>? items;
  final YuiTabEdge? edge;
  final YuiTabBarStyle tabBarStyle;

  /// Tab Page ID
  String get selectedPath => state.value;

  int get selectedIndex {
    final index = pages.keys.toList().indexWhere(
          (e) => e == selectedPath,
        );
    return index;
  }

  int get initialIndex {
    return pages.keys.toList().indexOf(initialPath);
  }

  /// Switch Tab
  void select(String path) {
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
