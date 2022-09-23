import 'package:flutter/material.dart';
import 'package:yui_kit/src/views/yui_colors.dart';
import 'package:yui_kit/src/views/yui_fonts.dart';
import 'package:yui_kit/src/views/yui_button_type.dart';

/// Button in Dialogs
class YuiDialogButton extends StatelessWidget {
  final YuiButtonType type;
  final String label;
  final void Function() onTap;
  const YuiDialogButton({
    Key? key,
    required this.type,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final FontWeight wight;
    late final Color color;
    switch (type) {
      case YuiButtonType.ok:
        wight = FontWeight.bold;
        color = yuiSystemBlue;
        break;
      case YuiButtonType.cancel:
        wight = FontWeight.normal;
        color = yuiSystemBlue;
        break;
      case YuiButtonType.danger:
        wight = FontWeight.bold;
        color = yuiSystemRed;
        break;
    }
    return TextButton(
      onPressed: onTap,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSizeH3,
            color: color,
            fontWeight: wight,
          ),
        ),
      ),
    );
  }
}
