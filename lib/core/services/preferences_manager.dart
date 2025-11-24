import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  //Factory Constructor to return singleton instance
  factory PreferencesManager() {
    return _instance;
  }

  //private constructor to prevent instantiation from outside
  PreferencesManager._internal();

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  remove(String key) async {
    await _preferences.remove(key);
  }

  clear() async {
    await _preferences.clear();
  }
}
