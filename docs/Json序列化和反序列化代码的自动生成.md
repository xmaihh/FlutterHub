先区分下 Json 的 `序列化` 和 `反序列化`

- **序列化**：对象或数据结构 → Json字符串
- **反序列化**：Json字符串 → 对象或数据结构

官方推荐使用 [json_serializable](https://pub.dev/packages/json_serializable) 这个 `Flutter编译时工具` 来生成Json序/反序列化代码,简化Json数据与Dart对象的转换，提供 **Json序列化和反序列化代码的自动生成**。

**详细用法:**

1. 添加依赖

    json_annotation → 定义注解。
    json_serializable → 使用这些注解来生成代码。
    build_runner → 执行生成代码的任务。

    ```
    # 方式一：终端直接键入下述命令安装
    flutter pub add json_annotation dev:build_runner dev:json_serializable
    
    # 方式2：打开 build.yaml文件手动添加依赖
    dependencies:
    flutter:
      sdk: flutter
    json_annotation: ^4.9.0
    
    dev_dependencies:
    flutter_test:
      sdk: flutter
    build_runner: ^2.4.12
    json_serializable: ^6.8.0
    ```


2. 基本使用

定义Model类添加属性，给类加上 `@JsonSerializable` 注解，并添加 `fromJson()` 和`toJson()` 方法：

```dart
import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart'; // 1.指定生成的文件，一般是当前文件.g.dart

@JsonSerializable() // 2.添加注解，告知此类是要生成Model类的
class Banner {
  @JsonKey(name: 'id') // 3.可选，添加注解，告知此属性对应的json key
  final int bid;
  final String desc;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  Banner({
    required this.bid,
    required this.desc,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  // 4、反序列化，固定写法：_${类名}FromJson(json)
  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  // 5、序列化，固定写法：_${类名}ToJson(this)
  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
```
编写完上述代码，编译器会报`_BannerFromJson`和`_BannerToJson`找不到，只要确定没拼写错误就行，直接执行下述命令生成对应的序列化代码：

```dart
flutter pub run build_runner build --delete-conflicting-outputs

# 后面的 --delete-conflicting-outputs 是可选的，作用是：
# 自动删除任何现存的，与即将生成的输出文件冲突的文件，然后继续构建过程。
# 这样可以清理由于老版本或不同构建配置造成的遗留文件
```

命令执行完，原先的报错就消失了，而且会在 同级目录 生成一个 xxx.g.dart 的文件。

更多可选配置：[json_serializable build configuration](https://pub.dev/packages/json_serializable#build-configuration)

QuickType网页: https://app.quicktype.io/  - 复制Json到左侧，右侧会自动生成Model类的代码