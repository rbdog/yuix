import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab_state.dart';
import 'package:yuix/src/router/yui_tab_router.dart';
import 'package:yuix/src/views/yui_tab_bar_item.dart';

class YuiTabBar extends StatefulWidget {
  const YuiTabBar(
    this.tabRouter, {
    super.key,
  });

  final YuiTabRouter tabRouter;

  @override
  State<YuiTabBar> createState() => _YuiTabBarState();
}

class _YuiTabBarState extends State<YuiTabBar> {
  YuiTabRouter get tabRouter => widget.tabRouter;

  @override
  void initState() {
    super.initState();
    widget.tabRouter.state.addListener(updateState);
  }

  @override
  void dispose() {
    widget.tabRouter.state.removeListener(updateState);
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
        final itemWidth = constraints.maxWidth / tabRouter.pages.length;
        final itemHeight = tabRouter.tabBarStyle.height;
        final paths = tabRouter.pages.keys.toList();

        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            paths.length,
            (index) {
              final path = paths[index];
              final isSelected = tabRouter.selectedIndex == index;
              final itemState = YuiTabState(
                index: index,
                isSelected: isSelected,
                path: path,
              );
              final itemBuilder = tabRouter.items?[path];

              return SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: YuiTabBarItem(
                  onTap: () {
                    tabRouter.select(path);
                  },
                  state: itemState,
                  builder: itemBuilder,
                ),
              );
            },
          ),
        );

        return row;
      },
    );

    return Material(
      elevation: 20,
      child: layoutBuilder,
    );
  }
}
