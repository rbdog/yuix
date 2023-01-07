import 'package:flutter/material.dart';

/// IconConnector
///
///    |    ←connector
///    ★    ←icon
///    |    ←connector
///
class IconConnector extends StatelessWidget {
  const IconConnector({
    super.key,
    required this.icon,
    required this.connectTop,
    required this.connectBottom,
    double? iconWidth,
    double? iconHeight,
    double? iconMargin,
    double? connectorWidth,
    Color? connectorColor,
  })  : iconWidth = iconWidth ?? 30,
        iconHeight = iconHeight ?? 30,
        iconMargin = iconMargin ?? 5,
        connectorWidth = connectorWidth ?? 3,
        connectorColor = connectorColor ?? Colors.grey;

  final Widget icon;
  final bool connectTop;
  final bool connectBottom;
  final double iconMargin;
  final double iconWidth;
  final double iconHeight;
  final double connectorWidth;
  final Color connectorColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: connectorWidth,
            color: connectTop ? connectorColor : null,
          ),
        ),
        SizedBox(height: iconMargin),
        Container(
          width: iconWidth,
          height: iconHeight,
          alignment: Alignment.center,
          child: icon,
        ),
        SizedBox(height: iconMargin),
        Flexible(
          flex: 1,
          child: Container(
            width: connectorWidth,
            color: connectBottom ? connectorColor : null,
          ),
        ),
      ],
    );
  }
}

/// IconConnectedList
///
///         +------+
///    ★    | item |
///    |    +------+
///    |
///    |    +------+
///    ★    | item |
///    |    +------+
///    |
///    |    +------+
///    ★    | item |
///         +------+
///
class IconConnectedList extends StatelessWidget {
  const IconConnectedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.iconBuilder,
    this.iconWidth,
    this.iconHeight,
    this.iconMargin,
    this.connectorWidth,
    this.connectorColor,
  });

  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final Widget Function(int index) iconBuilder;
  final double? iconWidth;
  final double? iconHeight;
  final double? iconMargin;
  final double? connectorWidth;
  final Color? connectorColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        itemCount,
        (index) {
          return IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: iconWidth,
                  child: IconConnector(
                    icon: iconBuilder(index),
                    connectTop: index != 0,
                    connectBottom: index != (itemCount - 1),
                    connectorWidth: connectorWidth,
                    connectorColor: connectorColor,
                    iconWidth: iconWidth,
                    iconHeight: iconHeight,
                    iconMargin: iconMargin,
                  ),
                ),
                Expanded(
                  child: itemBuilder(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
