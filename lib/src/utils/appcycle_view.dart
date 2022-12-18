import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
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

class AppcycleView extends StatefulWidget {
  const AppcycleView({
    Key? key,
    required this.cycle,
    required this.child,
  }) : super(key: key);

  final Appcycle cycle;
  final Widget child;

  @override
  AppcycleViewState createState() => AppcycleViewState();
}

class AppcycleViewState extends State<AppcycleView>
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
    widget.cycle.notifyLifecycle(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // Web Lifecycle
  void onVisibilityChange(Event e) {
    if (document.visibilityState == 'hidden') {
      widget.cycle.notifyLifecycle(AppLifecycleState.paused);
    } else if (document.visibilityState == 'visible') {
      widget.cycle.notifyLifecycle(AppLifecycleState.resumed);
    }
  }
}
