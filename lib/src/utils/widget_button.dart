import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  const WidgetButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
