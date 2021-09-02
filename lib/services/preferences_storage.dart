import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorageService {
  var prefs = SharedPreferences.getInstance();

  Future<void> set(String key, Object value) async {
    await (await prefs).setString(key, value.toString());
  }

  Future get(String key) async {
    return (await prefs).get(key);
  }
}
