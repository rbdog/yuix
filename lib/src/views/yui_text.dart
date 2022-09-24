import 'package:flutter/material.dart';
import 'package:yuix/src/views/yui_colors.dart';
import 'package:yuix/src/views/yui_fonts.dart';

// 指定したサイズが横幅に収まらなければ小さくなるテキスト
class YuiText extends StatelessWidget {
  final String value;
  final double fontSize;
  final Color color;
  final int maxLines;
  const YuiText(
    this.value, {
    this.color = yuiDarkGrey,
    this.fontSize = fontSizeReguler,
    this.maxLines = 5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        value,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
