import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hub/common/wan_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile.dart';
import 'net_cache.dart';

// 提供可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版本
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    //初始化网络请求相关配置
    Wan.init();
  }

  //持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
