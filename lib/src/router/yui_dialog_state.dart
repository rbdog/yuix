//
//
//

import 'package:yuix/src/router/yui_call.dart';
import 'package:yuix/src/views/yui_button_type.dart';

class YuiDialogState {
  YuiDialogState({
    required this.pattern,
    required this.path,
    required this.params,
  }) : call = YuiCall();

  final String pattern;
  final String path;
  final Map<String, String> params;
  final YuiCall call;

  /// Trigger event
  void send([String? value]) {
    call.streamer.sink.add(value);
  }

  /// Listen event
  void receive(void Function(String? value) action) {
    call.streamer.stream.listen((value) {
      action(value);
    });
  }

  /// wait button tap event
  Future<YuiButtonType> receiveTapEvent() {
    return call.completer.future;
  }

  /// send button tap event
  void sendTapEvent(YuiButtonType type) {
    call.completer.complete(type);
  }
}
