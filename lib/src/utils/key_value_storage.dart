import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  // ストレージ接続オブジェクトのキャッシュ
  SharedPreferences? _chacePrefs;

  // ストレージ接続オブジェクトの取得
  Future<SharedPreferences> _getPrefs() async {
    // null の場合だけ初回読み込みする
    _chacePrefs ??= await SharedPreferences.getInstance();
    return _chacePrefs!;
  }

  // int
  Future<void> saveInt(String key, int value) async {
    final prefs = await _getPrefs();
    prefs.setInt(key, value);
  }

  Future<int?> loadInt(String key) async {
    final prefs = await _getPrefs();
    return prefs.getInt(key);
  }

  // String
  Future<void> saveString(String key, String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  Future<String?> loadString(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  Future<void> removeString(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }

  // String List
  Future<void> saveStringList(String key, List<String> values) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(key, values);
  }

  Future<List<String>?> loadStringList(String key) async {
    final prefs = await _getPrefs();
    return prefs.getStringList(key);
  }

  // remove
  Future<void> remove(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }
}
