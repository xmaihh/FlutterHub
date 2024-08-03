import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/common/global.dart';
import 'package:flutter_hub/models/index.dart';

import '../utils/logger.dart';

class Wan {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Wan([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;
  late Options _options;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.wanandroid.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  static void init() {
    // 添加日志拦截器
    dio.interceptors.add(LogInterceptor());
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户cookie(可能为null,代表未登录)
    dio.options.headers[HttpHeaders.cookieHeader] = Global.profile.cookie;
  }

  // 登录接口，登录成功后返回用户信息
  Future<ResponseModel<UserInfo>> login(String username, String password) async {
    var r = await dio.get("user/login", options: _options.copyWith(extra: {"noCache": true})); //本接口禁用缓存
    //清空所有缓存
    Global.netCache.cache.clear();
    Log.error(r.data);
    return ResponseModel<UserInfo>.fromJson(r.data, (json) => UserInfo.fromJson(json));
  }
}
