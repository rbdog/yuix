//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab_body.dart';
import 'package:yuix/src/router/yui_tab_route.dart';
import 'package:yuix/src/views/yui_tab_bar.dart';
import 'package:yuix/src/views/yui_tab_bar_style.dart';
import 'package:yuix/src/views/yui_tab_edge.dart';

class YuiDefaultTabRoute extends YuiPureTabRoute {
  const YuiDefaultTabRoute(
    super.router, {
    super.key,
    this.edge = YuiTabEdge.bottom,
    this.tabBarStyle,
  });

  final YuiTabEdge? edge;
  final YuiTabBarStyle? tabBarStyle;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        if (edge == YuiTabEdge.top)
          YuiTabBar(
            router,
            style: tabBarStyle,
          ),
        YuiTabBody(router),
        if (edge == YuiTabEdge.bottom)
          YuiTabBar(
            router,
            style: tabBarStyle,
          ),
      ],
    );
    return Scaffold(
      body: body,
    );
  }
}
