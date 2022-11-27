//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/dialog_layer.dart';
import 'package:yuix/src/router/loading_layer.dart';
import 'package:yuix/src/router/page_layer.dart';
import 'package:yuix/src/router/yui_nav_router.dart';
import 'package:yuix/src/router/yui_nav_router_state.dart';

/// YuiNavRoute
class YuiNavRoute extends StatefulWidget {
  const YuiNavRoute(
    this.router, {
    Key? key,
  }) : super(key: key);

  /// router
  final YuiNavRouter router;

  @override
  State<YuiNavRoute> createState() => YuiNavRouteState();
}

/// YuiNavRouteState
class YuiNavRouteState extends State<YuiNavRoute> {
  late YuiNavRouterState state;

  void updateState() {
    final oldState = state;
    final newState = widget.router.state.value;
    setState(() {
      state = newState;
    });
    if (!oldState.drawerIsOpen && newState.drawerIsOpen) {
      widget.router.drawerKey.currentState?.openDrawer();
    }
    if (oldState.drawerIsOpen && !newState.drawerIsOpen) {
      widget.router.drawerKey.currentState?.closeDrawer();
    }
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
    final pageLayer = PageLayer(
      builders: widget.router.pages,
      states: state.pageStates,
      onPopPage: () => widget.router.pop(),
    );

    final pageLayerWithDrawer = Scaffold(
      drawer: widget.router.drawer?.call(),
      onDrawerChanged: (isOpened) {
        if (isOpened && !state.drawerIsOpen) {
          widget.router.slideIn();
        } else if (!isOpened && state.drawerIsOpen) {
          widget.router.slideOut();
        }
      },
      key: widget.router.drawerKey,
      body: pageLayer,
    );

    final stack = Stack(
      children: [
        pageLayerWithDrawer,
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
