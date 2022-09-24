//
//
//

import 'package:flutter/material.dart';
import 'package:yuix/src/router/ui_tab_router.dart';

class UiTabRouterWidget extends StatefulWidget {
  final UiTabRouter router;

  const UiTabRouterWidget(
    this.router, {
    Key? key,
  }) : super(key: key);

  @override
  State<UiTabRouterWidget> createState() => UiTabRouterWidgetState();
}

class UiTabRouterWidgetState extends State<UiTabRouterWidget>
    with TickerProviderStateMixin {
  // Manage State as index
  late TabController tabController;

  void updateState() {
    final index = widget.router.tabs
        .indexWhere((e) => e.path == widget.router.state.value);
    tabController.animateTo(index);
  }

  bool isSelected(String path) {
    final index = widget.router.tabs.indexWhere((e) => e.path == path);
    return tabController.index == index;
  }

  @override
  void initState() {
    super.initState();
    widget.router.state.addListener(updateState);

    final initialIndex = widget.router.tabs
        .indexWhere((e) => e.path == widget.router.initialPath);
    tabController = TabController(
      initialIndex: initialIndex,
      length: widget.router.tabs.length,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {}); // Update View Color
    });
  }

  @override
  void dispose() {
    widget.router.state.removeListener(updateState);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// 画面下のバー
    var tabBar = Container(
      height: widget.router.tabBarHeight,
      width: double.infinity,
      color: widget.router.tabBarColor,
      alignment: Alignment.center,
      child: TabBar(
        controller: tabController,
        labelPadding: EdgeInsets.zero,
        isScrollable: true,
        indicatorColor: widget.router.indicatorColor,
        indicatorWeight: widget.router.indicatorHeight,
        indicatorPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        tabs: [
          for (var page in widget.router.tabs)
            Container(
              color: (isSelected(page.path))
                  ? page.tabColorOnSelected
                  : page.tabColor,
              width: screenSize.width / widget.router.tabs.length,
              height:
                  widget.router.tabBarHeight - widget.router.indicatorHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (isSelected(page.path))
                      ? (page.tabIconOnSelected ?? page.tabIcon)
                      : page.tabIcon,
                  Text(
                    page.tabLabel,
                    style: TextStyle(
                      fontSize: page.tabLabelSize,
                      color: (isSelected(page.path))
                          ? page.tabLabelColorOnSelected
                          : page.tabLabelColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    /// 画面
    return Scaffold(
      bottomNavigationBar: tabBar,
      body: TabBarView(
        controller: tabController,
        children: widget.router.tabs.map((e) => e.build()).toList(),
      ),
    );
  }
}
