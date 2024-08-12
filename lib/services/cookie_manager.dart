import 'package:shared_preferences/shared_preferences.dart';

import '../utils/parse_expires_date.dart';

class CookieManager {
  static const String _cookieKey = 'auth_cookie';
  static const String _expiresKey = 'auth_expires';

  Future<void> saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cookieKey, cookie);
  }

  Future<void> saveExpires(String expiresDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_expiresKey, expiresDate);
  }

  Future<bool> isExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedExpiresTime = prefs.getString(_expiresKey);

    if (savedExpiresTime == null) {
      return true; // 如果没有保存的时间，认为已过期
    }

    DateTime? expiresDate = parseExpiresDate(savedExpiresTime);
    if (expiresDate == null) {
      return true; // 如果无法解析日期，认为已过期
    }

    bool isExpired = DateTime.now().isAfter(expiresDate);
    return isExpired;
  }

  Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cookieKey);
  }

  Future<void> clearCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cookieKey);
    await prefs.remove(_expiresKey);
  }
}
