import 'package:flutter/material.dart';
import 'dart:html';
import 'package:yuix/src/utils/lifecycle.dart';

/*
void onLifecycleEvent(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.resumed:
      break;
    case AppLifecycleState.inactive:
      break;
    case AppLifecycleState.paused:
      break;
    case AppLifecycleState.detached:
      break;
  }
}
*/

class LifecycleView extends StatefulWidget {
  final Widget child;
  final Lifecycle lifecycle;
  const LifecycleView({
    required this.lifecycle,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  LifecycleViewState createState() => LifecycleViewState();
}

class LifecycleViewState extends State<LifecycleView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    document.addEventListener("visibilitychange", onVisibilityChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    document.removeEventListener("visibilitychange", onVisibilityChange);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.lifecycle.notifyLifecycle(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // Web Lifecycle
  void onVisibilityChange(Event e) {
    if (document.visibilityState == 'hidden') {
      widget.lifecycle.notifyLifecycle(AppLifecycleState.paused);
    } else if (document.visibilityState == 'visible') {
      widget.lifecycle.notifyLifecycle(AppLifecycleState.resumed);
    }
  }
}
