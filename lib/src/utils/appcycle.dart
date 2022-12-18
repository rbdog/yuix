//
//
//

import 'package:flutter/scheduler.dart';

/// AppCycle イベント
enum AppcycleEvent {
  toBackground,
  toForeground,
  other,
}

/// イベントの観測者
class AppcycleHook {
  const AppcycleHook(
    this.id,
    this.event,
    this.onEvent,
  );

  /// ID
  final String id;

  /// 監視したいイベント
  final AppcycleEvent event;

  /// イベント発生時
  final void Function() onEvent;
}

class Appcycle {
  final List<AppcycleHook> _hooks = [];

  // フックイベントを追加
  void addHook(AppcycleHook hook) {
    _hooks.add(hook);
  }

  // フックイベントを削除
  void removeHook(String id) {
    _hooks.removeWhere((e) => e.id == id);
  }

  // Widget から イベント通知を受ける
  void notifyLifecycle(AppLifecycleState state) {
    late final AppcycleEvent targetEvent;
    switch (state) {
      case AppLifecycleState.paused:
        targetEvent = AppcycleEvent.toBackground;
        break;
      case AppLifecycleState.resumed:
        targetEvent = AppcycleEvent.toForeground;
        break;
      case AppLifecycleState.inactive:
        targetEvent = AppcycleEvent.other;
        break;
      case AppLifecycleState.detached:
        targetEvent = AppcycleEvent.other;
        break;
    }
    // 対象のオブサーバーたち
    final targetHooks = _hooks.where((e) => e.event == targetEvent);
    // オブザーバーたちに知らせる
    for (var hook in targetHooks) {
      hook.onEvent();
    }
  }
}
