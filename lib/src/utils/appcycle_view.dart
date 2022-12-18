import 'package:flutter/material.dart';
import 'dart:html';

/// AppCycle イベント
enum AppcycleEvent {
  toBackground,
  toForeground,
  other,
}

class AppcycleView extends StatefulWidget {
  const AppcycleView({
    super.key,
    required this.onAppcycle,
    required this.child,
  });

  final void Function(AppcycleEvent event) onAppcycle;
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
    document.removeEventListener("visibilitychange", onVisibilityChange);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // Mobile
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) {
      return;
    }
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onAppcycle(AppcycleEvent.toForeground);
        break;
      case AppLifecycleState.paused:
        widget.onAppcycle(AppcycleEvent.toBackground);
        break;
      default:
        widget.onAppcycle(AppcycleEvent.other);
        break;
    }
  }

  // Web
  void onVisibilityChange(Event e) {
    if (!mounted) {
      return;
    }
    if (document.visibilityState == 'hidden') {
      widget.onAppcycle(AppcycleEvent.toBackground);
    } else if (document.visibilityState == 'visible') {
      widget.onAppcycle(AppcycleEvent.toForeground);
    } else {
      widget.onAppcycle(AppcycleEvent.other);
    }
  }
}
