import 'package:flutter/material.dart';
import 'package:yuix/src/views/yui_tab_item.dart';
import 'package:yuix/src/router/yui_tab_state.dart';

class YuiTabBarItem extends StatelessWidget {
  const YuiTabBarItem({
    super.key,
    required this.onTap,
    required this.state,
    required this.builder,
  });

  final void Function() onTap;
  final YuiTabState state;
  final Widget Function(YuiTabState tab)? builder;

  @override
  Widget build(BuildContext context) {
    final defaultItem = YuiTabItem(
      state,
      icon: const Icon(Icons.circle),
      text: Text(state.path),
    );
    final isDefault = builder == null;
    Color? fgColor;
    if (isDefault) {
      fgColor = state.isSelected
          ? defaultItem.selectedColor
          : defaultItem.unselectedColor;
    }
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: fgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
    );
    return TextButton(
      onPressed: onTap,
      style: buttonStyle,
      child: builder?.call(state) ?? defaultItem,
    );
  }
}
