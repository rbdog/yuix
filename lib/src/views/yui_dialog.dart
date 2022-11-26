//
//
//
// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:yuix/src/router/yui_dialog_state.dart';
import 'package:yuix/src/router/yui_button_type.dart';
import 'package:yuix/src/views/yui_dialog_button.dart';
import 'package:yuix/src/views/yui_colors.dart';
import 'package:yuix/src/views/yui_fonts.dart';
import 'package:yuix/src/views/yui_text.dart';

/// Dialog
class YuiDialog extends StatelessWidget {
  const YuiDialog({
    this.title = 'title',
    this.description = 'description',
    this.preview,
    this.buttons = const [],
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget? preview;
  final List<YuiDialogButton> buttons;

  factory YuiDialog.test(YuiDialogState state) {
    return YuiDialog(
      title: 'Test',
      description: 'Hello Yui Dialog',
      buttons: [
        // Button
        YuiDialogButton.cancel(
          onTap: () => state.sendButtonEvent(YuiButtonType.ok),
        ),

        // Button
        YuiDialogButton.ok(
          onTap: () => state.sendButtonEvent(YuiButtonType.cancel),
        ),
      ],
    );
  }

  Widget buttonSetView() {
    if (buttons.isEmpty) {
      // No Button
      return const SizedBox(height: 20);
    } else if (buttons.length == 2) {
      // 2 Buttons
      return Column(
        children: [
          Container(
            width: 300,
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 149.5,
                child: buttons[0],
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.black.withOpacity(0.1),
              ),
              SizedBox(
                height: 50,
                width: 149.5,
                child: buttons[1],
              ),
            ],
          ),
        ],
      );
    } else {
      // Many Buttons
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final button in buttons)
            SizedBox(
              width: 300,
              height: 51,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: button,
                  )
                ],
              ),
            ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // title
    final titleView = Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: YuiText(
        title,
        color: yuiDarkGrey,
        fontSize: fontSizeH3,
        maxLines: 2,
      ),
    );

    // description
    final descriptionView = Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Text(
        description,
        maxLines: 8,
        style: const TextStyle(fontSize: fontSizeDetail, color: yuiGrey),
      ),
    );

    // preview
    final previewView = preview != null
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: yuiWhite,
            alignment: Alignment.center,
            child: preview,
          )
        : const SizedBox(height: 0);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: yuiWhite.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          titleView,
          descriptionView,
          previewView,
          buttonSetView(),
        ],
      ),
    );
  }
}
