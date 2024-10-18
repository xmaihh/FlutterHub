import 'package:flutter/material.dart';

class Constants {
  // API相关
  static const String baseUrl = 'https://www.wanandroid.com/';
  static const int connectionTimeout = 5000; // 毫秒
  static const int receiveTimeout = 3000; // 毫秒

  // API端点
  static const String loginEndpoint = 'user/login';
  static const String registerEndpoint = 'user/register';
  static const String logoutEndpoint = 'user/logout/json';
  static const String userInfoEndpoint = 'user/lg/userinfo/json';
  static const String topArticlesEndpoint = 'article/top/json';
  static String articlesEndpoint(int page) => "article/list/$page/json";
  static String collectEndpoint(int articleId) => "lg/collect/$articleId/json";
  static String uncollectEndpoint(int articleId) => "lg/uncollect_originId/$articleId/json";
  static String collectArticlesEndpoint(int page) => "lg/collect/list/$page/json";
  static const String bookmarkEndpoint = "lg/collect/usertools/json";
  static const String bannersEndpoint = 'banner/json';

  // 缓存相关
  static const String userCacheKey = 'user_cache';
  static const String themeCacheKey = 'theme_cache';
  static const String languageCacheKey = 'language_cache';

  // 路由相关
  static const String loginRoutePath = '/login';
  static const String signupRoutePath = '/signup';
  static const String forgotPasswdRoutePath = '/forgotPasswd';
  static const String themeRoutePath = '/mine/settings/theme';
  static const String languageRoutePath = '/mine/settings/language';
  static const String aboutRoutePath = '/mine/settings/about';
  static const String articleRoutePath = '/home/article';
  static const String favoriteRoutePath = '/mine/favorite';

  // UI相关
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  static const double defaultBorderRadius = 8.0;
  static const double smallBorderRadius = 4.0;
  static const double largeBorderRadius = 16.0;

  // 颜色 (使用时需要导入 'package:flutter/material.dart')
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color errorColor = Color(0xFFD32F2F);

  // 字体大小
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 20.0;

  // 动画时长
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // 分页相关
  static const int defaultPageSize = 20;

  // 正则表达式
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // 错误信息
  static const String networkErrorMessage = '网络连接错误,请检查您的网络设置';
  static const String unknownErrorMessage = '发生未知错误,请稍后重试';

  // 应用信息
  static const String appName = 'flutter_hub';
  static const String appVersion = '1.0.0';

  // 资源路径
  static const String imagePath = 'assets/images/';
  static const String iconPath = 'assets/icons/';

  // 其他常量
  static const int maxLoginAttempts = 5;
  static const int sessionTimeoutMinutes = 30;
}
