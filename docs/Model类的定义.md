# Model类的定义
先梳理下APP中将用到的数据，然后生成相应的`Dart Model`类。

Json文件转Dart Model的方案采用官方推荐的[json_serializable package](https://pub.dartlang.org/packages/json_serializable)包

## 注册/登录信息 => 返回用户信息
```json
{
  "admin": false,
  "chapterTops": [],
  "coinCount": 10,
  "collectIds": [],
  "email": "",
  "icon": "",
  "id": 162789,
  "nickname": "wana",
  "password": "",
  "publicName": "wana",
  "token": "",
  "type": 0,
  "username": "wana"
}
```
保存在“jsons”目录下的“userInfo.json”文件。

## 积分排名信息 => 通过请求个人信息接口获得
```json
{
  "coinCount": 0,
  "level": 1,
  "nickname": "",
  "rank": "3",
  "userId": 2,
  "username": "w**a"
}
```
保存在“jsons”目录下的“coinInfo.json”文件。

## 个人信息接口
```json
{
  "coinInfo?": "$coinInfo",
  "userInfo?": "$userInfo"
}
```
保存在“jsons”目录下的“user.json”文件。

## API缓存策略信息
```json
{
  "enable":true, // 是否启用缓存
  "maxAge":1000, // 缓存的最长时间，单位（秒）
  "maxCount":100 // 最大缓存数
}
```
保存在“jsons”目录下的“cacheConfig.json”文件。

## 用户信息
用户信息(Profile)应包括如下信息：
- 账号信息；由于我们的APP可以切换账号登录，且登录后再次打开则不需要登录，所以我们需要对用户账号信息和登录状态进行持久化。
- 应用使用配置信息；每一个用户都应有自己的APP配置信息，如主题、语言、以及数据缓存策略等。
- 用户注销登录后，为了便于用户在退出APP前再次登录，我们需要记住上次登录的用户名。

```json
{
  "user?":"$user", //账号信息，结构见"user.json"
  "cookie?":"", // 登录用户的token(oauth)或密码
  "theme":0, //主题索引
  "cache?":"$cacheConfig", // 缓存策略信息，结构见"cacheConfig.json"
  "lastLogin?":"", //最近一次的注销登录的用户名
  "locale?":"" // APP语言信息
}
```
保存在“jsons”目录下的“profile.json”文件。

# 生成Dart Model类

在项目中设置[json_serializable](https://pub.dev/packages/json_serializable) 和 [json_model](https://pub.dev/packages/json_model)
pubspec.yaml

```yaml
dependencies:
  # json_serializable依赖
  json_annotation: <最新版本>

dev_dependencies:
  # json_serializable依赖
  build_runner: <最新版本>
  json_serializable: <最新版本>
  # json_model依赖
  json_model: <最新版本>
```
添加完依赖，执行：
```bash
flutter packages pub get
```

需要的Json数据已经定义完毕，现在只需要运行json_model package提供的命令来通过json文件生成相应的Dart类：
```bash
dart run json_model
```
命令执行成功后，可以看到lib/models文件夹下会生成相应的Dart Model类：
```agsl
├── models
│   ├── cacheConfig.dart
│   ├── cacheConfig.g.dart
│   ├── coinInfo.dart
│   ├── coinInfo.g.dart
│   ├── index.dart
│   ├── profile.dart
│   ├── profile.g.dart
│   ├── user.dart
│   ├── user.g.dart
│   ├── userInfo.dart
│   └── userInfo.g.dart
```
