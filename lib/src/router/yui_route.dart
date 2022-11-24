//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router.dart';
import 'package:yuix/src/router/yui_nav_route.dart';
import 'package:yuix/src/router/yui_router_protocol.dart';
import 'package:yuix/src/router/yui_tab_route.dart';

/// YuiRoute
class YuiRoute extends StatelessWidget {
  const YuiRoute(
    YuiRouterProtocol router, {
    Key? key,
  })  : routerProtocol = router,
        super(key: key);

  final YuiRouterProtocol routerProtocol;

  static YuiRoute tabs(YuiTabRouter tabRouter) {
    return YuiRoute(tabRouter);
  }

  @override
  Widget build(BuildContext context) {
    if (routerProtocol is YuiRouter) {
      return YuiNavRoute(routerProtocol as YuiRouter);
    }
    if (routerProtocol is YuiTabRouter) {
      return YuiTabRoute(routerProtocol as YuiTabRouter);
    }
    throw Exception('unexpected router type');
  }
}
