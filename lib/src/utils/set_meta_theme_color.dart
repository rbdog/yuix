import 'dart:js' as js;

import 'package:flutter/material.dart';

extension ColorString on Color {
  String toHexString() {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

void setMetaThemeColor(Color color) {
  js.context.callMethod("setMetaThemeColor", [color.toHexString()]);
}

dynamic getSafeAreaInset() {
  final value = js.context.callMethod("getSafeAreaInset", []);
  return value;
}
