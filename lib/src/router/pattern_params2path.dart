import 'package:yuix/src/router/path_utils.dart' as lib;
import 'package:yuix/src/router/pattern_params.dart';

String patternParams2path(PatternParams patternParams) {
  return lib.patternToPath(
    patternParams.pattern,
    patternParams.params,
  );
}
