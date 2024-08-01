import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hub/common/wan_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cacheConfig.dart';
import '../models/profile.dart';
import 'net_cache.dart';

// 提供可选主题色
const _themes = <MaterialColor>[Colors.blue, Colors.cyan, Colors.teal, Colors.green, Colors.red];

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版本
  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      // 默认主题索引为0，代表蓝色
      profile = Profile()..theme = 0;
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    Wan.init();
  }

  //持久化Profile信息
  static saveProfile() => _prefs.setString("profile", jsonEncode(profile.toJson()));

  //持久化上次更新的时间信息
  static set lastShowUpdate(DateTime time) => _prefs.setString('lastShowUpdate', time.toIso8601String());

  // 获取上次更新的时间信息
  static DateTime get lastShowUpdate {
    String? lastShowUpdateStr = _prefs.getString('lastShowUpdate');
    if (lastShowUpdateStr == null) return DateTime(1970, 1, 1);
    return DateTime.parse(lastShowUpdateStr);
  }
}
