//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/utils/app_cycle.dart';
import 'package:yuix/src/utils/lifecycle_view.dart';

class AppCycleView extends StatelessWidget {
  final AppCycle appCycle;
  final Widget child;
  const AppCycleView({
    required this.appCycle,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifecycleView(
      lifecycle: appCycle.lifecycle,
      child: child,
    );
  }
}
