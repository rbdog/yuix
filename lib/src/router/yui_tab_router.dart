//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab.dart';

/// Router for Tab Pages
class YuiTabRouter {
  final String initialPath;
  final List<YuiTab> tabs;
  final Color tabBarColor;
  final double tabBarHeight;
  final Color indicatorColor;
  final double indicatorHeight;
  // location=path=state
  final ValueNotifier<String> state;

  /// Constructor
  YuiTabRouter({
    required this.initialPath,
    required this.tabs,
    this.tabBarColor = Colors.grey,
    this.tabBarHeight = 80,
    this.indicatorColor = Colors.blue,
    this.indicatorHeight = 2.0,
  }) : state = ValueNotifier(initialPath);

  /// Tab Page ID
  String get selectedPath => state.value;

  /// Switch Tab
  void select(String path) {
    state.value = path;
  }
}
