import 'package:flutter/material.dart';
import 'package:yuix/src/router/ui_task.dart';

/// LoadingLayer
class LoadingLayer extends StatelessWidget {
  final List<UiTask> tasks;
  final Widget Function(String label)? child;
  const LoadingLayer({
    required this.tasks,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tasks.isNotEmpty
        ? Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : Column(
            children: const [],
          );
  }
}
