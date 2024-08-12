import 'package:dio/dio.dart';
import 'package:flutter_hub/utils/parse_expires_date.dart';

import '../api/api_client.dart';
import '../common/constants.dart';
import '../common/global.dart';
import '../models/index.dart';
import '../utils/logger.dart';
import 'cookie_manager.dart';

class AuthService {
  final ApiClient _apiClient;
  final CookieManager _cookieManager;

  AuthService(this._apiClient, this._cookieManager);

  // 登录方法
  Future<ResponseModel<UserInfo>> login(String username, String password) async {
    try {
      final response = await _apiClient.post(Constants.loginEndpoint,
          data: FormData.fromMap({
            "username": username,
            "password": password,
          }));

      if (response.statusCode == 200) {
        // 解析并返回用户信息
        ResponseModel<UserInfo> res = ResponseModel<UserInfo>.fromJson(response.data, (json) => UserInfo.fromJson(json));
        if (res.errorCode == 0) {
          // 保存cookie
          _saveCookie(response);
        }
        return res;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // 注册方法
  Future<ResponseModel<UserInfo>> register(String username, String password, String repassword) async {
    try {
      final response = await _apiClient.post(Constants.registerEndpoint,
          data: FormData.fromMap({
            'username': username,
            'password': password,
            'repassword': password,
          }));

      if (response.statusCode == 200) {
        // 解析并返回用户信息
        ResponseModel<UserInfo> res = ResponseModel<UserInfo>.fromJson(response.data, (json) => UserInfo.fromJson(json));
        if (res.errorCode == 0) {
          // 保存cookie
          _saveCookie(response);
        }
        return res;
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
      await _cookieManager.clearCookie();

      ///清空所有缓存
      Global.netCache.cache.clear();
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

  Future<void> _saveCookie(Response response) async {
    List<String>? setCookieHeaders = response.headers.map['set-cookie'];
    String rawCookie = setCookieHeaders?.join('; ') ?? '';
    Log.info("原始cookie：sum=${setCookieHeaders?.length},content=$rawCookie");
    String? expiresTime = extractExpiresTime(rawCookie);
    Log.info('Expires 时间: $expiresTime');
    if (setCookieHeaders != null && rawCookie.isNotEmpty) {
      await _cookieManager.saveCookie(rawCookie);
    }
    if (expiresTime != null) {
      await _cookieManager.saveExpires(expiresTime);
    }
  }

  Future<bool> isLoggedIn() async {
    String? cookie = await _cookieManager.getCookie();
    bool isExpired = await _cookieManager.isExpired();
    return cookie != null && cookie.isNotEmpty && !isExpired;
  }
}
