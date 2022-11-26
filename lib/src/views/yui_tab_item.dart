import 'package:flutter/material.dart';

/// child of TabBarItem
class YuiTabItem extends StatelessWidget {
  const YuiTabItem({
    super.key,
    this.icon,
    this.text,
  });

  final Icon? icon;
  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) icon!,
        if (text != null) text!,
      ],
    );
  }
}
