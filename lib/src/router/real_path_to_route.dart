import 'package:yuix/src/router/pattern_path_to_param_keys.dart';
import 'package:yuix/src/router/path_utils.dart';
import 'package:yuix/src/router/ui_route.dart';
import 'package:yuix/src/router/ui_call.dart';

/// ('/a/3', ['/a/:id', '/b/:name'], ['id', 'name'], call)
UiRoute? realPathToRoute(
  String realPath, // '/a/3'
  List<String> patternPaths, // ['/a/:id', '/b/:name']
  bool withCall,
) {
  // 一致するパターンのパスを探す
  for (final patternPath in patternPaths) {
    final paramNames = patternPathToParamKeys(realPath);
    final regExp = patternToRegExp(patternPath, paramNames);
    final hasMatch = regExp.hasMatch(realPath);
    if (!hasMatch) continue;
    // 一致したとき
    // スラッシュの数が合わなければ誤動作なのでスルー
    // a/1/b が a/:i/b/:j に対しても反応してしまう様子
    final slashCountA = '/'.allMatches(patternPath).length;
    final slashCountB = '/'.allMatches(realPath).length;
    if (slashCountA != slashCountB) {
      continue;
    }
    var match = regExp.firstMatch(realPath)!;
    final params = extractPathParameters(paramNames, match);

    // UiRoute
    final route = UiRoute(
      patternPath: patternPath,
      params: params,
      call: withCall ? UiCall(params) : null,
      realPath: realPath,
    );
    return route;
  }
  return null;
}
