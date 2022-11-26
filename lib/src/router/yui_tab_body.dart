//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_tab_router.dart';
import 'package:yuix/src/router/yui_tab_state.dart';

class YuiTabBody extends StatefulWidget {
  const YuiTabBody(
    this.router, {
    Key? key,
  }) : super(key: key);

  final YuiTabRouter router;

  @override
  State<YuiTabBody> createState() => YuiTabBodyState();
}

class YuiTabBodyState extends State<YuiTabBody> {
  late final PageController controller;
  YuiTabRouter get router => widget.router;

  @override
  void initState() {
    super.initState();
    final index = router.selectedIndex;
    controller = PageController(initialPage: index);
    router.state.addListener(updateState);
  }

  @override
  void dispose() {
    router.state.removeListener(updateState);
    controller.dispose();
    super.dispose();
  }

  void updateState() {
    controller.animateToPage(
      router.selectedIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageView = PageView.builder(
      controller: controller,
      itemCount: router.pages.length,
      itemBuilder: (context, index) {
        final isSelected = router.selectedIndex == index;
        final itemState = YuiTabState(
          index: index,
          isSelected: isSelected,
          path: router.selectedPath,
        );
        return router.pages.values.toList()[index](itemState);
      },
      onPageChanged: (index) {
        router.selectIndex(index);
      },
    );

    return Expanded(
      child: pageView,
    );
  }
}
