//
//
//

class YuiPageState {
  YuiPageState({
    required this.pattern,
    required this.path,
    required this.params,
  });

  /// Pattern Path
  final String pattern;

  /// Real Path
  final String path;

  /// Path Params
  final Map<String, String> params;
}
