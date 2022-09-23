//
//
//

/// LoadingTask
class UiTask {
  /// Message Label
  final String label;

  /// Task Process
  final Function() action;
  const UiTask({
    required this.label,
    required this.action,
  });
}
