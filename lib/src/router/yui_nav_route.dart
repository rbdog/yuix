//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router.dart';
import 'package:yuix/src/router/dialog_layer.dart';
import 'package:yuix/src/router/loading_layer.dart';
import 'package:yuix/src/router/page_layer.dart';
import 'package:yuix/src/router/yui_nav_router_state.dart';

class YuiNavRoute extends StatefulWidget {
  const YuiNavRoute(
    this.router, {
    Key? key,
  }) : super(key: key);

  final YuiRouter router;

  @override
  State<YuiNavRoute> createState() => YuiNavRouteState();
}

class YuiNavRouteState extends State<YuiNavRoute> {
  late YuiNavRouterState state;

  void updateState() {
    setState(() {
      state = widget.router.state.value;
    });
  }

  @override
  void initState() {
    super.initState();
    state = widget.router.state.value;
    widget.router.state.addListener(updateState);
  }

  @override
  void dispose() {
    widget.router.state.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stack = Stack(
      children: [
        PageLayer(
          builders: widget.router.pages,
          states: state.pageStates,
          onPopPage: () => widget.router.pop(),
        ),
        DialogLayer(
          builders: widget.router.dialogs,
          states: state.dialogStates,
        ),
        LoadingLayer(
          tasks: state.tasks,
        ),
      ],
    );

    return stack;
  }
}
