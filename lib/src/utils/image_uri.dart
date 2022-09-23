//
//
//

/*
  # サーバーから送られてくる画像URLは ローカルの画像 を指定している時もある

  - オンラインを参照 https://sample.png
  - アプリ内フォルダを参照 assets://sample.png
  - フラッターの組み込みアイコンを参照 fluttericons://12345
*/

/// URIが指す場所の種類
enum ImageScheme {
  assets,
  network,
  flutterIcons,
}

class ImageUri {
  // 原型の文字列を保存
  final String rawValue;

  /// URLが指す場所の種類
  final ImageScheme scheme;

  /// Flutterで利用しやすい状態になった画像のパス
  final String flutterPath;

  // 不可視のコンストラクタ
  const ImageUri._(this.rawValue, this.scheme, this.flutterPath);

  // 公開用のコンストラクタ
  factory ImageUri(String imageUri) {
    final components = imageUri.split('://');
    final schemeString = components.first;
    ImageScheme? scheme;
    String? path;
    switch (schemeString) {
      case 'assets':
        scheme = ImageScheme.assets;
        path = 'assets/images/${components.last}';
        break;
      case 'http':
        scheme = ImageScheme.network;
        path = imageUri;
        break;
      case 'https':
        scheme = ImageScheme.network;
        path = imageUri;
        break;
      case 'fluttericons':
        scheme = ImageScheme.flutterIcons;
        path = components.last;
        break;
      default:
        return throw Exception('不正な画像指定です: $imageUri');
    }
    return ImageUri._(imageUri, scheme, path);
  }
}
