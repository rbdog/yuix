String calcRatioDiff(double target, double baseLine) {
  final ratio = target / baseLine;
  final diff = (ratio - 1.0) * 100;
  final diffStr = diff.toStringAsFixed(2);
  if (diff < 0) {
    return '$diffStr%';
  } else if (diff == 0) {
    return '± 0%';
  } else {
    return '+$diffStr%';
  }
}
