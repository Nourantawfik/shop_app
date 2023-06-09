
import 'package:shared_preferences/shared_preferences.dart';

class ChaceHelper {
  static late SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences =
    await SharedPreferences.getInstance() as SharedPreferences;
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) {
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);

    return sharedPreferences.setDouble(key, value);
  }

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  // return bool (yes remove (true) or false)
  static Future<bool> removeData({required String key}) {
    return sharedPreferences.remove(key);
  }
}
