//
//
//

import 'package:flutter/scheduler.dart';

// イベントの観測者
class LifecycleHook {
  // ID
  final String id;
  // 監視したいイベント
  final AppLifecycleState state;
  // イベント発生時
  final void Function() onLifecycleEvent;
  // コンストラクタ
  const LifecycleHook(
    this.id,
    this.state,
    this.onLifecycleEvent,
  );
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
    // オブザーバーたちに知らせる
    for (var hook in _hooks) {
      if (hook.state == state) {
        hook.onLifecycleEvent();
      }
    }
  }
}
