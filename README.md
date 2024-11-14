# 🚀 FlutterHub - WanAndroid Client

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.24.4-02569B.svg?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2.svg?logo=dart)](https://dart.dev/)
[![GitHub Actions](https://github.com/xmaihh/FlutterHub/actions/workflows/publish-to-release.yml/badge.svg)](https://github.com/xmaihh/FlutterHub/actions)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/xmaihh/FlutterHub)](https://github.com/xmaihh/FlutterHub/releases)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

使用 Flutter 开发的 WanAndroid 客户端，旨在展示 Flutter 应用开发的完整流程及工程结构。

[核心功能](#-核心功能) •
[技术要点](#-技术要点) •
[项目结构](#-项目结构) •
[开始使用](#-开始使用) •
[构建部署](#-构建部署) •

</div>

## ✨ 核心功能

- [x]  账号登录、退出登录
- [x] 主题切换功能
- [x] 多语言支持
- [x] 登录状态持久化
- [x] 响应式设计，支持多平台

## 🔍 技术要点

1. **网络请求**
   - 使用 Dio 处理 HTTPS 请求
   - 访问 WanAndroid 开放 API
   - API 文档：[WanAndroid 开放 API](https://www.wanandroid.com/blog/show/2)
2. **数据处理**
   - Json 序列化与反序列化
   - Dart Model 类自动生成
3. **状态管理**
   - 全局状态：语言、主题、登录状态
4. **本地存储**
   - 持久化用户登录信息
   - 本地缓存管理
5. **国际化**
   - 使用 Intl 包
   - ARB 文件管理多语言

## 📁 项目结构

```
lib/
├── api/          # 网络请求相关
├── common/       # 通用工具类和常量
├── l10n/         # 国际化相关
├── models/       # 数据模型
├── states/       # 全局状态管理
├── routes/       # 路由页面
├── utils/        # 工具类
└── widgets/      # 自定义组件

项目根目录/
├── android/      # Android 平台相关
├── ios/          # iOS 平台相关
├── windows/      # Windows 平台相关
├── macos/        # macos 平台相关
├── linux/        # linux 平台相关
├── web/          # Web 平台相关
├── fonts/        # 字体文件
├── imgs/         # 图片资源
├── jsons/        # Json 模板文件
└── l10n-arb/     # 多语言 arb 文件
```

## 📱 Screenshots

<div align="center">

### 📱 Mobile Experience

|                                 Home Screen                                  |                                     Settings                                     |                                      Message                                       |                                     TODO                                     |                                       Favorites                                        |                                      Signup                                      |                                     Login                                      |                                     About                                      |
|:----------------------------------------------------------------------------:|:--------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------:|:----------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------:|:------------------------------------------------------------------------------:|:------------------------------------------------------------------------------:|
| <img src="/docs/screenshot/mobile/home.png" width="360" alt="Mobile Home" /> | <img src="/docs/screenshot/mobile/mine.png" width="360" alt="Mobile Settings" /> | <img src="/docs/screenshot/mobile/message.png" width="360" alt="Mobile Message" /> | <img src="/docs/screenshot/mobile/todo.png" width="360" alt="Mobile TODO" /> | <img src="/docs/screenshot/mobile/favorites.png" width="360" alt="Mobile Favorites" /> | <img src="/docs/screenshot/mobile/signup.png" width="360" alt="Mobile Signup" /> | <img src="/docs/screenshot/mobile/login.png" width="360" alt="Mobile Login" /> | <img src="/docs/screenshot/mobile/about.png" width="360" alt="Mobile About" /> |

### 🖥️ Windows Desktop Experience

|                                                Dashboard View                                                |                                               Analysis Screen                                               |
|:------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------:|
| <img src="/docs/screenshot/desktop/home.png" width="790" style="max-width: 100%;" alt="Desktop Dashboard" /> | <img src="/docs/screenshot/desktop/mine.png" width="790" style="max-width: 100%;" alt="Desktop Analysis" /> |

</div>

## 🚀 开始使用

### 环境要求
```bash
flutter --version
Flutter 3.24.4 • channel stable
Dart 3.5.4
```

### 安装与运行

1. 克隆项目
```bash
git clone https://github.com/xmaihh/FlutterHub.git -b fl_wan
cd FlutterHub
```

2. 安装依赖
```bash
flutter pub get
```

3. 运行项目
```bash
# 普通运行
flutter run

# Web 运行（解决 CORS 问题）
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

## ⚙️ 构建部署

项目使用 GitHub Actions 自动构建和发布，支持以下平台：
- Windows (.exe)
- macOS (.dmg)
- Linux 
- Android (.apk)
- iOS (.ipa)
- Web

触发条件：

- 推送到fl_wan分支
- 手动触发工作流程

主要步骤包括：

- 配置 Flutter 环境
- 安装依赖
- 根据 `Git commit count` 更新 `pubspec.yaml` 中的版本号
- 使用矩阵策略为不同平台构建应用（Android、iOS、Web、Linux、Windows、macOS）
- 创建 GitHub 发布版本
- 上传构建产物

查看我们的工作流程配置文件[workflow configuration](.github/workflows/publish-to-release.yml)了解详情。

### 手动构建

```bash
# Windows
flutter build windows

# macOS
flutter build macos

# Linux
flutter build linux

# Android
flutter build apk

# iOS
flutter build ios --no-codesign

# web
flutter build web --base-href=/flutterhub/

# 生成代码
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📦 常量配置

项目使用统一的常量管理，包含：
- API 相关常量（接口地址、超时设置等）
- 缓存相关常量
- UI 相关常量（间距、圆角、颜色等）
- 字体和动画配置
- 错误信息
- 应用信息

详见 `lib/common/constants.dart`

## 🤝 贡献代码

欢迎提交 Issue 和 Pull Request。

## 📄 开源协议

本项目基于 MIT 协议开源，详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- 感谢 [Flutter](https://flutter.dev) 团队提供了这个优秀的框架
- 感谢 [玩Android API](https://www.wanandroid.com/blog/show/2) 的详细文档
- 感谢所有 [贡献者](https://github.com/xmaihh/FlutterHub/graphs/contributors) 的付出

---

<div align="center">

Made with ❤️ by [xmaihh](https://github.com/xmaihh)

⭐️ 如果这个项目帮助到你，欢迎点星鼓励！

</div>
