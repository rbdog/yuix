//
//
//

import 'package:flutter/scheduler.dart';

/// AppCycle イベント
enum AppCycleEvent {
  toBackground,
  toForeground,
  other,
}

/// イベントの観測者
class LifecycleHook {
  const LifecycleHook(
    this.id,
    this.event,
    this.onEvent,
  );

  /// ID
  final String id;

  /// 監視したいイベント
  final AppCycleEvent event;

  /// イベント発生時
  final void Function() onEvent;
}

class Lifecycle {
  final List<LifecycleHook> _hooks = [];

  // フックイベントを追加
  void addHook(LifecycleHook hook) {
    _hooks.add(hook);
  }

  // フックイベントを削除
  void removeHook(String id) {
    _hooks.removeWhere((e) => e.id == id);
  }

  // Widget から イベント通知を受ける
  void notifyLifecycle(AppLifecycleState state) {
    late final AppCycleEvent targetEvent;
    switch (state) {
      case AppLifecycleState.paused:
        targetEvent = AppCycleEvent.toBackground;
        break;
      case AppLifecycleState.resumed:
        targetEvent = AppCycleEvent.toForeground;
        break;
      case AppLifecycleState.inactive:
        targetEvent = AppCycleEvent.other;
        break;
      case AppLifecycleState.detached:
        targetEvent = AppCycleEvent.other;
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
