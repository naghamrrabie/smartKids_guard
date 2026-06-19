
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // الدالة دي بنناديها مرة واحدة في الـ main.dart أول ما الأبلكيشن يفتح
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // دالة لحفظ أي نوع داتا
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  // دالة لقراءة الداتا
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // دالة لمسح داتا معينة (هنستخدمها وقت الـ Logout)
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}