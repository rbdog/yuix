//
//
//
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:yuix/src/views/yui_colors.dart';
import 'package:yuix/src/views/yui_fonts.dart';
import 'package:yuix/src/views/yui_button_type.dart';

class _OkButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final double width;
  final double height;
  final Color color;
  const _OkButton({
    required this.label,
    required this.onTap,
    this.width = 150,
    this.height = 50,
    this.color = yuiSystemBlue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(height / 5),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: fontSizeH3,
                color: yuiWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final double width;
  final double height;
  const _CancelButton({
    required this.label,
    required this.onTap,
    this.width = 150,
    this.height = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: yuiSystemBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: yuiSystemBlue, width: 1.5),
        ),
        onPressed: onTap,
        child: Container(
          margin: EdgeInsets.all(height / 5),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: fontSizeH3,
                color: yuiSystemBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Button
class YuiButton extends StatelessWidget {
  final YuiButtonType type;
  final double width;
  final double height;
  final String label;
  final void Function()? onTap;
  const YuiButton({
    Key? key,
    required this.type,
    this.width = 150,
    this.height = 50,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case YuiButtonType.ok:
        return _OkButton(
          label: label,
          width: width,
          height: height,
          onTap: onTap,
        );
      case YuiButtonType.cancel:
        return _CancelButton(
          label: label,
          width: width,
          height: height,
          onTap: onTap,
        );
      case YuiButtonType.danger:
        return _OkButton(
          label: label,
          width: width,
          height: height,
          onTap: onTap,
          color: yuiSystemRed,
        );
    }
  }
}
