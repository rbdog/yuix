//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_route.dart';
import 'package:yuix/src/router/yui_router.dart';

/// PageLayer
class PageLayer extends StatelessWidget {
  final List<YuiRoute> routes; // 現在の状態
  final Map<Path, PageBuilder> pages; // 全てのページのデータ
  final void Function() onPopPage;

  const PageLayer({
    required this.pages,
    required this.routes,
    required this.onPopPage,
    Key? key,
  }) : super(key: key);

  MaterialPage buildPage(YuiRoute route) {
    final builder = pages[route.pattern];
    if (builder != null) {
      return MaterialPage(child: builder(route.params));
    } else {
      throw Exception('Not found UiPage for: ${route.pattern}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return const Text('Pages is Empty');
    }
    final navigator = Navigator(
      pages: [
        for (final route in routes) buildPage(route),
      ],
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          onPopPage();
        }
        return false; // disable pop of the framework
      },
    );

    return navigator;
  }
}
