import 'dart:async';

class UiCall {
  final Map<String, String> params;
  final streamer = StreamController<String?>();
  UiCall(this.params);

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
