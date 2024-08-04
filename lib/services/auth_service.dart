import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import '../common/constants.dart';
import '../models/user.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final String _cookieKey = 'auth_cookie';

  // 登录方法
  Future<User> login(String username, String password) async {
    try {
      final response = await _apiClient.post(
        Constants.loginEndpoint,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // 保存cookie
        _saveCookie(response);

        // 解析并返回用户信息
        return User.fromJson(response.data['data']);
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // 注册方法
  Future<User> register(String username, String password, String email) async {
    try {
      final response = await _apiClient.post(
        Constants.registerEndpoint,
        data: {
          'username': username,
          'password': password,
          'repassword': password,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // 保存cookie
        _saveCookie(response);

        // 解析并返回用户信息
        return User.fromJson(response.data['data']);
      } else {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // 登出方法
  Future<void> logout() async {
    try {
      await _apiClient.get(Constants.logoutEndpoint);
    } catch (e) {
      print('Logout failed: $e');
    } finally {
      // 无论是否成功调用登出API，都清除本地存储的cookie
      await _clearCookie();
    }
  }

  // 获取当前登录用户信息
  Future<User?> getCurrentUser() async {
    try {
      final response = await _apiClient.get(Constants.userInfoEndpoint);
      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      }
    } catch (e) {
      print('Failed to get current user: $e');
    }
    return null;
  }

  // 保存cookie
  Future<void> _saveCookie(Response response) async {
    String? rawCookie = response.headers.map['set-cookie']?.first;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      String cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cookieKey, cookie);
    }
  }

  // 获取存储的cookie
  Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cookieKey);
  }

  // 清除cookie
  Future<void> _clearCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cookieKey);
  }

  // 检查是否已登录
  Future<bool> isLoggedIn() async {
    String? cookie = await getCookie();
    return cookie != null && cookie.isNotEmpty;
  }
}


//使用这个AuthService的例子
//final authService = AuthService();
//
//// 登录
//try {
//User user = await authService.login('username', 'password');
//print('Logged in as: ${user.username}');
//} catch (e) {
//print('Login failed: $e');
//}
//
//// 检查登录状态
//bool isLoggedIn = await authService.isLoggedIn();
//print('Is logged in: $isLoggedIn');
//
//// 获取当前用户
//User? currentUser = await authService.getCurrentUser();
//if (currentUser != null) {
//print('Current user: ${currentUser.username}');
//} else {
//print('No user is currently logged in');
//}
//
//// 登出
//await authService.logout();