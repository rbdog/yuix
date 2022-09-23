import 'dart:convert';
import 'package:jose/jose.dart';
import 'package:crypto/crypto.dart';

/// 新しい Jwk を発行する
String newJwk() {
  const algorithm = JsonWebAlgorithm.es256;
  final jwk = algorithm.generateRandomKey();
  final json = jsonEncode(jwk);
  return json;
}

/// Jwk から pubJwk を取り出す
String pubJwk({required String jwk}) {
  final json = jsonDecode(jwk);
  final fullJwk = JsonWebKey.fromJson(json);
  final keyPair = fullJwk.cryptoKeyPair;
  final pubJwk = JsonWebKey.fromCryptoKeys(publicKey: keyPair.publicKey);
  final pubJwkStr = jsonEncode(pubJwk);
  return pubJwkStr;
}

/// pubJwk から addr を作成する
String addr({required String pubJwk}) {
  final intList = const Utf8Encoder().convert(pubJwk);
  final digestBytes = sha256.convert(intList).bytes;
  final base64 = base64Encode(digestBytes);
  final prefix32 = base64.substring(0, 32);
  return prefix32;
}

/// 署名
String sign({
  required String sigContent,
  required String jwk,
}) {
  final json = jsonDecode(jwk);
  final fullJwk = JsonWebKey.fromJson(json);
  final sigConBuf = const Utf8Encoder().convert(sigContent);
  final sigBuf = fullJwk.sign(sigConBuf);
  final sig = base64Encode(sigBuf);
  return sig;
}

/// 検証
bool verify({
  required String sig,
  required String sigContent,
  required String pubJwk,
}) {
  final json = jsonDecode(pubJwk);
  final jwk = JsonWebKey.fromJson(json);
  final sigConBuf = const Utf8Encoder().convert(sigContent);
  final sigBuf = const Utf8Encoder().convert(sig);
  return jwk.verify(sigConBuf, sigBuf, algorithm: 'ES512');
}
