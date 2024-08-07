import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState with ChangeNotifier {
  static const String _themeColorKey = 'theme_color';
  static const String _themeModeKey = 'theme_mode';

  // 预定义的主题颜色
  static const List<MaterialColor> themeColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  late MaterialColor _primaryColor;
  late ThemeMode _themeMode;

  ThemeState() {
    _primaryColor = themeColors[0]; // 默认使用蓝色
    _themeMode = ThemeMode.system; // 默认跟随系统
    _loadPreferences();
  }

  MaterialColor get primaryColor => _primaryColor;

  ThemeMode get themeMode => _themeMode;

  // 加载保存的偏好设置
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorIndex = prefs.getInt(_themeColorKey) ?? 0;
    final modeIndex = prefs.getInt(_themeModeKey) ?? 0;

    _primaryColor = themeColors[colorIndex.clamp(0, themeColors.length - 1)];
    _themeMode = ThemeMode.values[modeIndex.clamp(0, ThemeMode.values.length - 1)];

    notifyListeners();
  }

  // 保存偏好设置
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeColorKey, themeColors.indexOf(_primaryColor));
    await prefs.setInt(_themeModeKey, ThemeMode.values.indexOf(_themeMode));
  }

  // 切换主题颜色
  void setThemeColor(MaterialColor color) {
    _primaryColor = color;
    _savePreferences();
    notifyListeners();
  }

  // 切换主题模式
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _savePreferences();
    notifyListeners();
  }

  // 获取当前主题
  ThemeData get lightTheme {
    return ThemeData(
      // primarySwatch: _createMaterialColor(_primaryColor),
      // brightness: Brightness.light,
      // 可以在这里添加更多的主题定制

      // theme:
      // ThemeData(
        useMaterial3: true, // Optional: enables Material 3 design
        brightness: Brightness.light,
        primaryColor: primaryColor, primarySwatch: primaryColor,
        colorScheme: const ColorScheme.light().copyWith(primary: primaryColor),
      //   // colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      // ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      // primarySwatch: _createMaterialColor(_primaryColor),
      // brightness: Brightness.dark,
      // 可以在这里添加更多的主题定制

      // ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryColor, primarySwatch: primaryColor,
        colorScheme: const ColorScheme.dark().copyWith(primary: primaryColor),
      //   // colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
      // ),
    );
  }

  // 辅助方法: 从单一颜色创建 MaterialColor
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

//使用示例
//更改颜色和主题
//// 改变主题颜色
//Provider.of<ThemeState>(context, listen: false).setThemeColor(Colors.red);
//
//// 切换到深色模式
//Provider.of<ThemeState>(context, listen: false).setThemeMode(ThemeMode.dark);
