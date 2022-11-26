import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_dialog_state.dart';
import 'package:yuix/src/router/yui_nav_router.dart';

/// DialogLayer
class DialogLayer extends StatelessWidget {
  final List<YuiDialogState> states;
  final Map<Path, DialogBuilder> builders;
  const DialogLayer({
    Key? key,
    required this.builders,
    required this.states,
  }) : super(key: key);

  Widget buildDialog(YuiDialogState state) {
    final builder = builders[state.pattern];
    if (builder != null) {
      return builder(state);
    } else {
      return Text(
        'Not found UiDialog for: ${state.pattern}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (states.isEmpty) {
      return const SizedBox.shrink();
    }

    final dialogNavigator = Navigator(
      pages: [
        MaterialPage(
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SingleChildScrollView(
                child: buildDialog(states.first),
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
