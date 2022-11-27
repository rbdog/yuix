import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab_state.dart';
import 'package:yuix/src/router/yui_tab_router.dart';
import 'package:yuix/src/views/yui_tab_bar_item.dart';
import 'package:yuix/src/views/yui_tab_bar_style.dart';
import 'package:yuix/src/views/yui_tab_item.dart';

class YuiTabBar extends StatefulWidget {
  const YuiTabBar(
    this.router, {
    super.key,
    YuiTabBarStyle? style,
  }) : style = style ?? const YuiTabBarStyle();

  final YuiTabRouter router;
  final YuiTabBarStyle style;

  @override
  State<YuiTabBar> createState() => _YuiTabBarState();
}

class _YuiTabBarState extends State<YuiTabBar> {
  YuiTabRouter get router => widget.router;

  @override
  void initState() {
    super.initState();
    widget.router.state.addListener(updateState);
  }

  @override
  void dispose() {
    widget.router.state.removeListener(updateState);
    super.dispose();
  }

  void updateState() {
    // rebuild
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final layoutBuilder = LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / router.pages.length;
        final itemHeight = widget.style.height;
        final paths = router.pages.keys.toList();

        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            paths.length,
            (index) {
              final path = paths[index];
              final isSelected = router.selectedPath == path;
              final itemState = YuiTabState(
                index: index,
                isSelected: isSelected,
                path: path,
              );
              final itemColor = isSelected
                  ? widget.style.selectedItemColor
                  : widget.style.itemColor;
              final itemChildBuilder = router.items?[path];
              final itemChildColor = isSelected
                  ? widget.style.selectedItemChildColor
                  : widget.style.itemChildColor;
              final defaultItemChild = YuiTabItem(
                icon: const Icon(Icons.circle),
                text: Text(path),
              );
              final itemChild =
                  itemChildBuilder?.call(itemState) ?? defaultItemChild;

              return Container(
                width: itemWidth,
                height: itemHeight,
                color: itemColor,
                child: YuiTabBarItem(
                  onTap: () {
                    router.select(path);
                  },
                  color: itemColor,
                  childColor: itemChildColor,
                  child: itemChild,
                ),
              );
            },
          ),
        );

        return row;
      },
    );

    return Material(
      color: widget.style.color,
      elevation: widget.style.elevation,
      child: layoutBuilder,
    );
  }
}
