//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/ui_tab.dart';

/// Router for Tab Pages
class UiTabRouter {
  final String initialPath;
  final List<UiTab> tabs;
  final Color tabBarColor;
  final double tabBarHeight;
  final Color indicatorColor;
  final double indicatorHeight;
  // location=path=state
  final ValueNotifier<String> state;

  /// Constructor
  UiTabRouter({
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
