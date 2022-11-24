import 'dart:async';

import 'package:yuix/src/views/yui_button_type.dart';

class YuiCall {
  final streamer = StreamController<String?>();
  final completer = Completer<YuiButtonType>();

  /// dispose
  void dispose() {
    streamer.close();
  }
}
