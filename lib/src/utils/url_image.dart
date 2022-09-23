import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// なぜこの Widget が必要か
// https://github.com/flutter/flutter/issues/49725
class UrlImage extends StatelessWidget {
  final String url;
  // ignore: use_key_in_widget_constructors
  const UrlImage(this.url);
  @override
  Widget build(BuildContext context) {
    // なぜこの　ignoreコメント が必要か
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int viewId) => ImageElement()..src = url,
    );
    return HtmlElementView(
      viewType: url,
    );
  }
}
