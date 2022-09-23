//
// イベント検知
//   アプリは イベント に依存してはならない
//     - (イベントが正常に検知されるとは限らない前提で作ること)
//     - (イベントはログやアナリティクスのみに利用すること)
//

// イベントの種類
enum EventType {
  showPage,
  showDialog,
  userAction,
  systemAction,
  error,
}

// イベント 1つ
class Event {
  // イベントの種類
  final EventType type;

  /* 以下のいずれか必須 */
  // 画面ID
  final String? pageId;
  // ダイアログID
  final String? dialogId;
  // ユーザーアクションID
  final String? userActionId;
  // システムアクションID
  final String? systemActionId;
  // エラーID
  final String? errorId;

  /// コンストラクタ
  const Event({
    required this.type,
    this.pageId,
    this.dialogId,
    this.userActionId,
    this.systemActionId,
    this.errorId,
  });

  // ログ用にフォーマットされた文字列
  String logFmt() {
    final String label;
    switch (type) {
      case EventType.showPage:
        label = 'PAG-$pageId';
        break;
      case EventType.showDialog:
        label = 'DLG-$dialogId';
        break;
      case EventType.userAction:
        label = 'USR-$userActionId';
        break;
      case EventType.systemAction:
        label = 'SYS-$systemActionId';
        break;
      case EventType.error:
        label = 'ERR-$errorId';
        break;
    }
    return label;
  }
}

// イベントの観測者
abstract class EventObserver {
  // イベント発生時
  void onEvent(Event event);
}

// イベント収集所
class EventCenter {
  // 直近 N 個のイベント
  final maxCount = 30;
  final List<Event> _recentEvents = [];
  final List<EventObserver> _observers = [];

  // オブザーバーを追加
  void addObserver(EventObserver observer) {
    _observers.add(observer);
  }

  // イベント発生を報告
  void notifyEvent(Event event) {
    // 多すぎるときは先頭を削除
    if (_recentEvents.length >= maxCount) {
      _recentEvents.removeAt(0);
    }
    // 新しいイベントを末尾へ追加
    _recentEvents.add(event);
    // オブザーバーたちに知らせる
    for (var observer in _observers) {
      observer.onEvent(event);
    }
  }

  // 全てのオブザーバーを削除
  void clearObservers() {
    _observers.clear();
  }

  // 全てのイベントを削除
  void clearEvents() {
    _recentEvents.clear();
  }

  // 最近のイベントをダンプ
  List<String> recentLogs() {
    final List<String> logs = [];
    for (final e in _recentEvents) {
      logs.add(e.logFmt());
    }
    return logs;
  }
}
