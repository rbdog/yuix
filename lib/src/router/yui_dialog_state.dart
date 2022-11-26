//
//
//

import 'dart:async';

import 'package:yuix/src/router/yui_button_type.dart';

class YuiDialogState {
  YuiDialogState({
    required this.pattern,
    required this.path,
    required this.params,
  });

  /// custom event completer
  final streamer = StreamController<String?>();

  /// button action completer
  final completer = Completer<YuiButtonType>();

  /// pattern path
  final String pattern;

  /// real path
  final String path;

  /// path params
  final Map<String, String> params;

  /// Trigger event
  void send([String? value]) {
    streamer.sink.add(value);
  }

  /// Listen event
  void receive(void Function(String? value) action) {
    streamer.stream.listen((value) {
      action(value);
    });
  }

  /// wait button tap event
  Future<YuiButtonType> receiveButtonEvent() {
    return completer.future;
  }

  /// send button tap event
  void sendButtonEvent(YuiButtonType type) {
    completer.complete(type);
  }

  /// dispose
  void dispose() {
    streamer.close();
  }
}
