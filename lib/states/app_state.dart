import 'package:flutter/material.dart';

import '../models/user.dart';

class AppState with ChangeNotifier {
  User? _user;
  Locale _locale = Locale('en', '');
  ThemeMode _themeMode = ThemeMode.system;

  User? get user => _user;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}