import 'package:flutter/material.dart';
import 'package:yui_kit/src/views/yui_colors.dart';

class RectIconButton extends StatelessWidget {
  final double size;
  final IconData icon;
  final BorderRadius cornerRadius;
  final void Function()? onTap;

  const RectIconButton({
    this.size = 50,
    required this.icon,
    this.cornerRadius = BorderRadius.zero,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: yuiWhite,
        shape: BoxShape.rectangle,
        borderRadius: cornerRadius,
        border: Border.all(
          color: onTap == null ? yuiGrey : yuiSystemBlue,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: cornerRadius,
        onTap: onTap,
        child: Icon(
          icon,
          color: onTap == null ? yuiGrey : yuiSystemBlue,
          size: 40,
        ),
      ),
    );
  }
}
