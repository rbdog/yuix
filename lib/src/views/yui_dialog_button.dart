import 'package:flutter/material.dart';
import 'package:yuix/src/views/yui_colors.dart';
import 'package:yuix/src/views/yui_fonts.dart';
import 'package:yuix/src/router/yui_button_type.dart';

/// Button in Dialogs
class YuiDialogButton extends StatelessWidget {
  const YuiDialogButton({
    Key? key,
    this.type = YuiButtonType.ok,
    this.label = '',
    this.onTap,
  }) : super(key: key);

  final YuiButtonType type;
  final String label;
  final void Function()? onTap;

  factory YuiDialogButton.cancel({
    void Function()? onTap,
  }) {
    return YuiDialogButton(
      type: YuiButtonType.cancel,
      label: 'Cancel',
      onTap: onTap,
    );
  }

  factory YuiDialogButton.ok({
    void Function()? onTap,
  }) {
    return YuiDialogButton(
      type: YuiButtonType.ok,
      label: 'OK',
      onTap: onTap,
    );
  }

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
