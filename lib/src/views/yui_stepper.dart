import 'package:flutter/material.dart';
import 'package:yui_kit/src/views/rect_icon_button.dart';
import 'package:yui_kit/src/views/yui_colors.dart';
import 'package:yui_kit/src/views/yui_fonts.dart';

class YuiStepper extends StatelessWidget {
  final int maxCount;
  final int minCount;
  final int count;
  final double width;
  final void Function(int newCount) updateCount;

  const YuiStepper({
    Key? key,
    required this.maxCount,
    required this.minCount,
    required this.count,
    required this.updateCount,
    this.width = 220,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// マイナスボタン
    final minusIsActive = (count > minCount);
    const minusRadius = BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
    );
    final minusOnTap = minusIsActive
        ? () {
            updateCount(count - 1);
          }
        : null;
    final minusBtn = RectIconButton(
      icon: Icons.remove,
      cornerRadius: minusRadius,
      onTap: minusOnTap,
    );

    // プラスボタン
    final plusIsActive = (count < maxCount);
    const plusRadius = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    );
    final plusOnTap = plusIsActive
        ? () {
            updateCount(count + 1);
          }
        : null;
    final plusBtn = RectIconButton(
      icon: Icons.add,
      cornerRadius: plusRadius,
      onTap: plusOnTap,
    );

    /// 真ん中の数字テキスト
    final fieldIsActive = minusIsActive || plusIsActive;
    final numberField = Container(
      alignment: Alignment.center,
      width: width - 100,
      height: 50,
      decoration: BoxDecoration(
        color: yuiWhite,
        border: Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide(
              width: 1.0, color: fieldIsActive ? yuiSystemBlue : yuiGrey),
        ),
      ),
      child: Text(
        '$count',
        style: const TextStyle(fontSize: fontSizeH2),
      ),
    );

    /// 横に並べる
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        minusBtn,
        numberField,
        plusBtn,
      ],
    );
  }
}
