//
//
//

/// Deployment Environment
enum DeployEnv {
  dev('DEV'),
  stg('STG'),
  prod('PROD');

  final String rawValue;
  const DeployEnv(this.rawValue);

  factory DeployEnv.from({required String rawValue}) {
    final value = DeployEnv.values.firstWhere((e) => e.rawValue == rawValue);
    return value;
  }
}
