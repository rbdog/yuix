import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_route.dart';
import 'package:yuix/src/router/yui_router.dart';

/// DialogLayer
class DialogLayer extends StatelessWidget {
  final List<YuiRoute> routes; // 表示するダイアログ
  final Map<Path, DialogBuilder> dialogs; // 全てのダイアログのデータ
  const DialogLayer({
    Key? key,
    required this.dialogs,
    required this.routes,
  }) : super(key: key);

  Widget buildDialog(YuiRoute route) {
    final builder = dialogs[route.pattern];

    if (builder != null) {
      return builder(route.call!);
    } else {
      return Text(
        'Not found UiDialog for: ${route.pattern}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) {
      return const SizedBox.shrink();
    }

    final dialogNavigator = Navigator(
      pages: [
        MaterialPage(
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SingleChildScrollView(
                child: buildDialog(routes.first),
              ),
            ),
          ),
        ),
      ],
      onPopPage: (route, result) {
        return false; // disable pop of the framework
      },
    );

    return dialogNavigator;
  }
}
