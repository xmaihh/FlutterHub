import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class WanLocalizations {
  static Future<WanLocalizations> load(Locale locale) {
    final String name = (locale.countryCode ?? "").isEmpty == true ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return WanLocalizations();
    });
  }

  static WanLocalizations of(BuildContext context) {
    return Localizations.of<WanLocalizations>(context, WanLocalizations)!;
  }

  String get app_name => Intl.message('FlutterHub', name: 'app_name');

  String get nav_home => Intl.message('Home', name: 'nav_home');

  String get nav_login => Intl.message('Login', name: 'nav_login');

  String get nav_settings => Intl.message('Settings', name: 'nav_settings');

  String get settings_theme => Intl.message('Theme', name: 'settings_theme');

  String get settings_language => Intl.message('Language', name: 'settings_language');

  String get settings_language_auto => Intl.message('Auto', name: 'settings_language_auto');

  String get settings_about => Intl.message('About', name: 'settings_about');

  String get settings_app_version => Intl.message('Version', name: 'settings_app_version');

  String get settings_check_for_updates => Intl.message('Check for updates', name: 'settings_check_for_updates');

  String settings_update_msg_rate_limit(String retryTime) => Intl.message("Rate limit exceeded, please retry after $retryTime ", args: [retryTime], name: 'settings_update_msg_rate_limit');

  String get settings_update_msg_app_up_to_date => Intl.message('Your application is up to date', name: 'settings_update_msg_app_up_to_date');

  String get settings_update_msg_check_failed => Intl.message('Update check failed, please try again later', name: 'settings_update_msg_check_failed');

  String get settings_update_title_new_version_available => Intl.message('New version available', name: 'settings_update_title_new_version_available');

  String settings_update_msg_new_version_found(String version) => Intl.message("A new version $version is available, do you want to update?", args: [version], name: 'settings_update_msg_new_version_found');

  String get settings_update_action_cancel => Intl.message('Cancel', name: 'settings_update_action_cancel');

  String get settings_update_action_update => Intl.message('Update', name: 'settings_update_action_update');

  String get settings_app_license => Intl.message('License', name: 'settings_app_license');
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
