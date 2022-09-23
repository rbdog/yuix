//
//
//

import 'package:yui_kit/src/router/ui_call.dart';

/// UiRoute
class UiRoute {
  final String patternPath;
  final Map<String, String> params;
  final UiCall? call;
  final String realPath;
  UiRoute({
    required this.patternPath,
    required this.params,
    required this.call,
    required this.realPath,
  });
}
