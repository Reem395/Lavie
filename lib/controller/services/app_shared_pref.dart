import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late SharedPreferences sharedPreferences;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();
  static Future setToken(userToken) async =>
      await sharedPreferences.setString("accessToken", userToken);
  static String? getToken() => sharedPreferences.getString("accessToken");

  static Future setUserMail(userMail) async =>
      await sharedPreferences.setString("userMail", userMail);
  static String? getUserMail() => sharedPreferences.getString("userMail");

  static Future setNextExamDate({required DateTime nextExamDate}) async =>
      await sharedPreferences.setString(
          "NextExamDate", nextExamDate.toString());
  static String? getNextExamDate() =>
      sharedPreferences.getString("NextExamDate");
}
