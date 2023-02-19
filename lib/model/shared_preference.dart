import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<bool> isValuePresentSP(String key) async {
    final prefers = await SharedPreferences.getInstance();
    final checkValue = prefers.containsKey(key);
    return checkValue;
  }

  static Future<String> getStringValueSP(String key) async {
    final prefers = await SharedPreferences.getInstance();
    final stringValue = prefers.getString(key);
    if (stringValue == null) {
      return "";
    } else {
      return stringValue;
    }
  }

  static Future<void> addStringToSP(key, value) async {
    final prefers = await SharedPreferences.getInstance();
    await prefers.setString(key, value);
  }

  static Future<void> clearDB(key, value) async {
    final prefers = await SharedPreferences.getInstance();
    await prefers.clear();
  }
}
