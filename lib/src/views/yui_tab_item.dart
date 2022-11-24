import 'package:flutter/material.dart';
import 'package:yuix/yuix.dart';

/// Item Widget for a tab
class YuiTabItem extends StatelessWidget {
  const YuiTabItem(
    this.state, {
    super.key,
    this.icon,
    this.text,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  });

  final YuiTabState state;
  final Icon? icon;
  final Text? text;
  final Color selectedColor;
  final Color unselectedColor;

  Color get color {
    return state.isSelected ? selectedColor : unselectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(
            icon!.icon,
            color: color,
          ),
        if (text != null)
          Text(
            text!.data ?? '',
            style:
                text!.style?.copyWith(color: color) ?? TextStyle(color: color),
          ),
        if (text == null && icon == null)
          Text(
            state.path,
            style: TextStyle(color: color),
          ),
      ],
    );
  }
}
