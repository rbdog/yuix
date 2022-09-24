import 'dart:async';

class YuiCall {
  final Map<String, String> params;
  final streamer = StreamController<String?>();
  YuiCall(this.params);

  /// Trigger event
  void event([String? value]) {
    streamer.sink.add(value);
  }

  /// Listen event
  void onEvent(void Function(String? value) action) {
    streamer.stream.listen((value) {
      action(value);
    });
  }

  void dispose() {
    streamer.close();
  }
}
