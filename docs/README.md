# wanandroid客户端示例
实现一个简单的wanandroid客户端。这个示例的主要目标：**使用Flutter来开发一个完整的APP，了解Flutter应用开发流程及工程结构**

计划要实现的功能如下：
- [ ] 实现wanandroid帐号登录、退出登录功能
- [ ] 支持换肤
- [ ] 支持多语言
- [ ] 登录状态持久化

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
├── common
├── l10n
├── models
├── states
├── routes
└── widgets
```

| 文件夹  | 作用                                                         |
| ------- | ------------------------------------------------------------ |
| common  | 一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等 |
| l10n    | 国际化相关的类都在此目录下                                   |
| models  | Json文件对应的Dart Model类会在此目录下                       |
| states  | 保存APP中需要跨组件共享的状态类                              |
| routes  | 存放所有路由页面类                                           |
| widgets | APP内封装的一些Widget组件都在该目录下                        |