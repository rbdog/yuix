//
//
//

/// Task
class YuiTask {
  /// Message Label
  final String label;

  /// Task Process
  final Function() action;
  const YuiTask({
    required this.label,
    required this.action,
  });
}
