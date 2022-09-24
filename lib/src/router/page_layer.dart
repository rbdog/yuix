//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/ui_route.dart';
import 'package:yuix/src/router/ui_router.dart';

/// PageLayer
class PageLayer extends StatelessWidget {
  final List<UiRoute> routes; // 現在の状態
  final Map<Path, UiPage> pages; // 全てのページのデータ
  final void Function() onPopPage;

  const PageLayer({
    required this.pages,
    required this.routes,
    required this.onPopPage,
    Key? key,
  }) : super(key: key);

  MaterialPage buildPage(UiRoute route) {
    final builder = pages[route.patternPath];
    if (builder != null) {
      return MaterialPage(child: builder(route.params));
    } else {
      throw Exception('Not found UiPage for: ${route.patternPath}');
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
