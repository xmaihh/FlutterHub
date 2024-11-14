# wanandroid客户端示例
实现一个简单的wanandroid客户端。这个示例的主要目标：**使用Flutter来开发一个完整的APP，了解Flutter应用开发流程及工程结构**

实现的功能如下：
- [ ✔ ] 实现wanandroid帐号登录、退出登录功能
- [ ✔ ] 支持换肤
- [ ✔ ] 支持多语言
- [ ✔ ] 登录状态持久化

要实现上面这些功能会涉及到如下技术点：
1. 网络请求：需要使用https请求wanandroid API
2. Json转Dart Model类
3. 全局状态管理；语言、主题、登录状态等都需要全局共享。
4. 持久化存储；保存登录信息，用户信息等。
5. 支持国际化、Intl包的使用

玩Android 开放API接口地址： https://www.wanandroid.com/blog/show/2

工程结构如下：
```agsl
github_client_app
├── android
├── fonts
├── l10n-arb
├── imgs
├── ios
├── jsons
├── lib
├── linux
├── macos
├── web
├── windows
└── test
```

外部图片资源和Icon资源分别包尊在`imgs`和`fonts`文件夹，由于在网络数据传输和持久化时，需要通过Json来传输、保存数据；但是在应用开发时我们又需要将Json转成Dart Model类，所以，我们需要在根目录下再创建一个用于保存Json文件的“jsons”文件夹。“l10n”文件夹，用于保存各国语言对应的arb文件

Dart代码都在`lib`文件夹下，lib文件夹目录如下:
```agsl
lib
├── api
├── common
├── l10n
├── models
├── states
├── routes
└── widgets
```

| 文件夹     | 作用                                                 |
|---------| ---------------------------------------------------- |
| api     |  网络请求使用dio包处理网络请求                                                    |
| common  | 通用方法类、保存全局变量的静态类等 |
| l10n    | 国际化相关的类都在此目录下                            |
| models  | Json文件对应的Dart Model类会在此目录下                |
| states  | 保存APP中需要跨组件共享的状态类                       |
| routes  | 存放所有路由页面类                                    |
| utils   |    一些工具类                                          |
| widgets | APP内封装的一些Widget组件都在该目录下                 |

`constants.dart`用于存储应用程序中使用的各种常量,包括API相关的常量、UI相关的常量、以及其他全局使用的常量值。

```dart
class Constants {
  // API相关
  static const String baseUrl = 'https://www.wanandroid.com/';
  static const int connectionTimeout = 5000; // 毫秒
  static const int receiveTimeout = 3000; // 毫秒

  // API端点
  static const String loginEndpoint = 'user/login';
  static const String registerEndpoint = 'user/register';
  static const String articlesEndpoint = 'article/list/';
  static const String bannersEndpoint = 'banner/json';

  // 缓存相关
  static const String userCacheKey = 'user_cache';
  static const String themeCacheKey = 'theme_cache';
  static const String languageCacheKey = 'language_cache';

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
  static const String appName = 'WanAndroid';
  static const String appVersion = '1.0.0';

  // 资源路径
  static const String imagePath = 'assets/images/';
  static const String iconPath = 'assets/icons/';

  // 其他常量
  static const int maxLoginAttempts = 5;
  static const int sessionTimeoutMinutes = 30;
}
```

包含了以下几个主要部分:

- API相关常量: 包括基础URL、超时设置和各种API端点。
- 缓存相关常量: 用于本地存储的键名。
- UI相关常量: 包括内边距、圆角半径、颜色等UI设计中常用的值。
- 字体大小常量: 定义了不同级别的字体大小。
- 动画时长常量: 用于保持应用中动画时长的一致性。
- 分页相关常量: 如默认的每页数据条数。
- 正则表达式: 用于验证邮箱、密码等。
- 错误信息: 预定义的错误消息。
- 应用信息: 如应用名称和版本号。
- 资源路径: 指定图片和图标等资源的路径。
- 其他常量: 如最大登录尝试次数、会话超时时间等。

使用这样一个集中的常量文件有以下好处:

- 提高代码的可维护性: 所有常量都在一个地方定义,方便修改和管理。
- 减少硬编码: 避免在代码中直接使用字符串或数字字面量。
- 提高代码的一致性: 确保整个应用中使用相同的值。
- 便于国际化: 可以轻松地将文本常量替换为本地化的字符串。

# 运行项目

由 CORS 策略引起的接口调用错误：`The XMLHttpRequest onError callback was called`。您可以在 Chrome 中使用`disable-web-security`命令调试应用程序时禁用它
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```