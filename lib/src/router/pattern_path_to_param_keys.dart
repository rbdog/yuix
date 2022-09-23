///
/// /a/b/:id/c/:name => [id, name]
///
List<String> patternPathToParamKeys(patternPath) {
  final List<String> paramNames = [];
  final postColons = patternPath.split(':');
  for (final postColon in postColons) {
    final preSlash = postColon.split('/').first;
    if (!paramNames.contains(preSlash)) {
      paramNames.add(preSlash);
    }
  }
  paramNames.remove('');
  return paramNames;
}
