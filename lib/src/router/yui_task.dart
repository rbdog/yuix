//
//
//

/// Task
class YuiTask {
  const YuiTask({
    required this.label,
    required this.action,
  });

  /// Message Label
  final String label;

  /// Task Process
  final Function() action;
}
