import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab_body.dart';
import 'package:yuix/src/router/yui_tab_router.dart';

class YuiPureTabRoute extends StatelessWidget {
  const YuiPureTabRoute(
    this.router, {
    super.key,
  });

  final YuiTabRouter router;

  @override
  Widget build(BuildContext context) {
    final bodyWithDrawer = Scaffold(
      drawer: router.drawer?.call(),
      onDrawerChanged: (isOpened) {
        if (isOpened && !router.state.value.drawerIsOpen) {
          router.slideIn();
        } else if (!isOpened && router.state.value.drawerIsOpen) {
          router.slideOut();
        }
      },
      key: router.drawerKey,
      body: YuiTabBody(router),
    );

    return bodyWithDrawer;
  }
}
