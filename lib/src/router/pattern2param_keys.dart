///
/// /a/b/:id/c/:name => [id, name]
///
List<String> pattern2paramKeys(pattern) {
  final List<String> paramKeys = [];
  final postColons = pattern.split(':');
  for (final postColon in postColons) {
    final preSlash = postColon.split('/').first;
    if (!paramKeys.contains(preSlash)) {
      paramKeys.add(preSlash);
    }
  }
  paramKeys.remove('');
  return paramKeys;
}
