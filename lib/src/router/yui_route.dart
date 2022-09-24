//
//
//

import 'package:yuix/src/router/yui_call.dart';

/// YuiRoute
class YuiRoute {
  final String pattern;
  final Map<String, String> params;
  final YuiCall? call;
  final String path;
  YuiRoute({
    required this.pattern,
    required this.params,
    required this.call,
    required this.path,
  });
}
