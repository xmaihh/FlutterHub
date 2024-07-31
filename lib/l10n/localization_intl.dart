import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class WanLocalizations {
  static Future<WanLocalizations> load(Locale locale) {
    final String name = (locale.countryCode ?? "").isEmpty == true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return WanLocalizations();
    });
  }

  static WanLocalizations of(BuildContext context) {
    return Localizations.of<WanLocalizations>(context, WanLocalizations)!;
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
  String get home => Intl.message('FlutterHub', name: 'home');
  String get language => Intl.message('Language', name: 'language');
  String get login => Intl.message('Login', name: 'login');
  String get auto => Intl.message('Auto', name: 'auto');
  String get setting => Intl.message('Setting', name: 'setting');
  String get theme => Intl.message('Theme', name: 'theme');
}

//Locale代理类
class WanLocalizationsDelegate extends LocalizationsDelegate<WanLocalizations> {
  const WanLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<WanLocalizations> load(Locale locale) {
    //3
    return WanLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(WanLocalizationsDelegate old) => false;
}
