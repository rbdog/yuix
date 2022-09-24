//
//
//

import 'package:flutter/material.dart';

/// Tab Page
class YuiTab {
  final String path;
  final Color tabColor;
  final Color tabColorOnSelected;
  final Widget tabIcon;
  final Widget? tabIconOnSelected;
  final String tabLabel;
  final Color tabLabelColor;
  final Color tabLabelColorOnSelected;
  final double tabLabelSize;
  final Widget Function() build;
  const YuiTab({
    required this.path,
    this.tabColor = Colors.white,
    this.tabColorOnSelected = Colors.blue,
    required this.tabIcon,
    this.tabIconOnSelected,
    required this.tabLabel,
    required this.build,
    this.tabLabelColor = Colors.grey,
    this.tabLabelColorOnSelected = Colors.white,
    this.tabLabelSize = 12,
  });
}
