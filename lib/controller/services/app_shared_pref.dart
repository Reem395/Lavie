import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late SharedPreferences sharedPreferences;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();
  static Future setToken(userToken) async =>
      await sharedPreferences.setString("accessToken", userToken);
  static String? getToken() => sharedPreferences.getString("accessToken");

  static Future clearUserToken() async =>
      await sharedPreferences.remove('accessToken');

  static Future setUserMail(userMail) async =>
      await sharedPreferences.setString("userMail", userMail);
  static String? getUserMail() => sharedPreferences.getString("userMail");

  static Future setUserId(userId) async =>
      await sharedPreferences.setString("userId", userId);
  static String? getUserId() => sharedPreferences.getString("userId");

  static Future setUserName(userName) async =>
      await sharedPreferences.setString("userName", userName);
  static String? getUserName() => sharedPreferences.getString("userName");

  static Future setNextExamDate({required DateTime nextExamDate}) async =>
      await sharedPreferences.setString(
          "NextExamDate", nextExamDate.toString());
  static String? getNextExamDate() =>
      sharedPreferences.getString("NextExamDate");

  static dynamic getDataFromSharedPreference({required String key}) {
    return sharedPreferences.get(key);
  }

  // static Future<bool> saveDataSharedPreference(
  //     {required String key, required dynamic value}) async {
  //   if (value is bool) {
  //     return await sharedPreferences.setBool(key, value);
  //   } else if (value is String) {
  //     return await sharedPreferences.setString(key, value);
  //   } else if (value is int) {
  //     return await sharedPreferences.setInt(key, value);
  //   } else {
  //     return await sharedPreferences.setDouble(key, value);
  //   }
  // }

  // static Future<bool> removeData({required String key}) async {
  //   return await sharedPreferences.remove(key);
  // }

  // static Future clearData() {
  //   return sharedPreferences.clear();
  // }
}
