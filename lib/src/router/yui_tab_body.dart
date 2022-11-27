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
  var animatingCount = 0;

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

  void updateState() async {
    animatingCount += 1;
    await controller.animateToPage(
      router.selectedIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    animatingCount -= 1;
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
        // onPageChanged is unexpectedly called during animation with animateToPage
        // https://github.com/flutter/flutter/issues/43813
        // if use flag, multi animation is not controlled

        if (animatingCount == 0) {
          router.selectIndex(index);
        }
      },
    );

    return Expanded(
      child: pageView,
    );
  }
}
