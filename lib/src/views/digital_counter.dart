import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yuix/src/views/yui_colors.dart';
import 'package:yuix/src/views/yui_fonts.dart';

class DigitalCounter extends StatelessWidget {
  final int count;
  const DigitalCounter(this.count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    var digits = formatter.format(count);
    final text = FittedBox(
      fit: BoxFit.fitHeight,
      child: Text(
        digits,
        maxLines: 1,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontFamily: fontDigital,
          fontSize: fontSizeH1,
          color: digitalYellow,
        ),
      ),
    );
    final deco = BoxDecoration(
      color: digitalBlack,
      borderRadius: BorderRadius.circular(8),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 2),
      decoration: deco,
      child: Row(
        children: [
          const Spacer(),
          text,
        ],
      ),
    );
  }
}
