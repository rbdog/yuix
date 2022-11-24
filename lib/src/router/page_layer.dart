//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_page_state.dart';
import 'package:yuix/src/router/yui_router.dart';

/// PageLayer
class PageLayer extends StatelessWidget {
  final List<YuiPageState> states; // 現在の状態
  final Map<Path, PageBuilder> builders; // 全てのページのデータ
  final void Function() onPopPage;

  const PageLayer({
    required this.builders,
    required this.states,
    required this.onPopPage,
    Key? key,
  }) : super(key: key);

  MaterialPage buildPage(YuiPageState state) {
    final builder = builders[state.pattern];
    if (builder != null) {
      return MaterialPage(child: builder(state));
    } else {
      throw Exception('Not found UiPage for: ${state.pattern}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (states.isEmpty) {
      return const Text('Pages is Empty');
    }
    final navigator = Navigator(
      pages: [
        for (final state in states) buildPage(state),
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
