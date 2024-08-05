import 'package:shared_preferences/shared_preferences.dart';

class CookieManager {
  static const String _cookieKey = 'auth_cookie';

  Future<void> saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cookieKey, cookie);
  }

  Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cookieKey);
  }

  Future<void> clearCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cookieKey);
  }
}