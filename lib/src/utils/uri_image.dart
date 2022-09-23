import 'package:flutter/material.dart';
import 'package:yui_kit/src/utils/image_uri.dart';

/// URLから画像を表示する
class UriImage extends StatelessWidget {
  final ImageUri imageUri;
  final double? width;
  final double? height;
  final Color? color;

  UriImage(
    String uri, {
    this.width,
    this.height,
    this.color,
    Key? key,
  })  : imageUri = ImageUri(uri),
        super(key: key);

  Widget buildImage() {
    switch (imageUri.scheme) {
      case ImageScheme.assets:
        return Image.asset(
          imageUri.flutterPath,
          fit: BoxFit.contain,
        );
      case ImageScheme.network:
        return Image.network(
          imageUri.flutterPath,
          errorBuilder: (context, exception, stackTrace) {
            // エラー画像 = プレースホルダー
            return const Placeholder();
          },
        );
      case ImageScheme.flutterIcons:
        final codePoint = int.parse(imageUri.flutterPath);
        final iconData = IconData(codePoint);
        final icon = Icon(iconData);
        return icon;
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = buildImage();

    late final ColorFiltered coloredImage;
    if (color != null) {
      coloredImage = ColorFiltered(
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        child: image,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: (color == null) ? image : coloredImage,
    );
  }
}
