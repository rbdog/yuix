import 'package:yuix/src/router/pattern2param_keys.dart';
import 'package:yuix/src/router/path_utils.dart';
import 'package:yuix/src/router/yui_route.dart';
import 'package:yuix/src/router/yui_call.dart';

/// ('/a/3', ['/a/:id', '/b/:name'], ['id', 'name'], call)
YuiRoute? path2route(
  String path, // '/a/3'
  List<String> patterns, // ['/a/:id', '/b/:name']
  bool withCall,
) {
  // 一致するパターンのパスを探す
  for (final pattern in patterns) {
    final paramKeys = pattern2paramKeys(path);
    final regExp = patternToRegExp(pattern, paramKeys);
    final hasMatch = regExp.hasMatch(path);
    if (!hasMatch) continue;
    // 一致したとき
    // スラッシュの数が合わなければ誤動作なのでスルー
    // a/1/b が a/:i/b/:j に対しても反応してしまう様子
    final slashCountA = '/'.allMatches(pattern).length;
    final slashCountB = '/'.allMatches(path).length;
    if (slashCountA != slashCountB) {
      continue;
    }
    var match = regExp.firstMatch(path)!;
    final params = extractPathParameters(paramKeys, match);

    // UiRoute
    final route = YuiRoute(
      pattern: pattern,
      params: params,
      call: withCall ? YuiCall(params) : null,
      path: path,
    );
    return route;
  }
  return null;
}
