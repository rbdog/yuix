//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/dialog_layer.dart';
import 'package:yuix/src/router/loading_layer.dart';
import 'package:yuix/src/router/page_layer.dart';
import 'package:yuix/src/router/yui_router_state.dart';
import 'package:yuix/src/router/yui_router.dart';

/// YuiRouterView
class YuiRouterView extends StatefulWidget {
  final YuiRouter router;

  const YuiRouterView(
    this.router, {
    Key? key,
  }) : super(key: key);

  @override
  State<YuiRouterView> createState() => YuiRouterViewState();
}

class YuiRouterViewState extends State<YuiRouterView> {
  late YuiRouterState state;

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
          pages: widget.router.pages,
          routes: state.pageRoutes,
          onPopPage: () => widget.router.pop(),
        ),
        DialogLayer(
          dialogs: widget.router.dialogs,
          routes: state.dialogRoutes,
        ),
        LoadingLayer(
          tasks: state.tasks,
        ),
      ],
    );

    return stack;
  }
}
