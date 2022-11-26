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
    return Scaffold(
      body: YuiTabBody(router),
    );
  }
}
