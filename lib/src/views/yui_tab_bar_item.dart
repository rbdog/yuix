import 'package:flutter/material.dart';

class YuiTabBarItem extends StatelessWidget {
  const YuiTabBarItem({
    super.key,
    required this.onTap,
    required this.color,
    required this.childColor,
    required this.child,
  });

  final void Function() onTap;
  final Color? color;
  final Color? childColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: color,
      foregroundColor: childColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
    );
    return TextButton(
      onPressed: onTap,
      style: buttonStyle,
      child: child,
    );
  }
}
