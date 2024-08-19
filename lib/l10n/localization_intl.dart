import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = (locale.countryCode ?? "").isEmpty == true ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get app_name => Intl.message('FlutterHub', name: 'app_name');

  String get nav_home => Intl.message('Home', name: 'nav_home');

  String get nav_login => Intl.message('Login', name: 'nav_login');

  String get login_title => Intl.message('Welcome Back', name: 'login_title');

  String get login_subtitle => Intl.message('Enter your credential to login', name: 'login_subtitle');

  String get login_username_label => Intl.message('Username', name: 'login_username_label');

  String get login_username_validator => Intl.message('Enter your username', name: 'login_username_validator');

  String get login_password_label => Intl.message('Password', name: 'login_password_label');

  String get login_password_validator => Intl.message('Enter your password', name: 'login_password_validator');

  String get login_btn_forgot_password => Intl.message('Forgot password?', name: 'login_btn_forgot_password');

  String get login_other_method => Intl.message('Or', name: 'login_other_method');

  String get login_btn_login => Intl.message('Login', name: 'login_btn_login');

  String get login_no_account => Intl.message("Don't have an account? ", name: 'login_no_account');

  String get login_btn_signup => Intl.message('Sign Up', name: 'login_btn_signup');

  String login_message_welcome_login_successful(String username) => Intl.message('Login successful, $username. Welcome back!', args: [username], name: 'login_message_welcome_login_successful');

  String get nav_signup => Intl.message('Signup', name: 'nav_signup');

  String get signup_title => Intl.message('Sign up', name: 'signup_title');

  String get signup_subtitle => Intl.message('Create your account', name: 'signup_subtitle');

  String get signup_username_label => Intl.message('Username', name: 'signup_username_label');

  String get signup_password_label => Intl.message('Password', name: 'signup_password_label');

  String get signup_confirm_password_label => Intl.message('Confirm Password', name: 'signup_confirm_password_label');

  String get signup_username_validator => Intl.message('Enter your username', name: 'signup_username_validator');

  String get signup_password_validator => Intl.message('Enter your password', name: 'signup_password_validator');

  String get signup_confirm_password_validator => Intl.message('Enter your confirm password', name: 'signup_confirm_password_validator');

  String get signup_password_mismatch_error => Intl.message('Passwords do NOT match!', name: 'signup_password_mismatch_error');

  String get signup_btn_signup => Intl.message('Sign up', name: 'signup_btn_signup');

  String get signup_already_have_an_account => Intl.message('Already have an account? ', name: 'signup_already_have_an_account');

  String get signup_btn_login => Intl.message('Login', name: 'signup_btn_login');

  String signup_message_welcome_signup_successful(String username) => Intl.message('Welcome $username, signup successful!', args: [username], name: 'signup_message_welcome_signup_successful');

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

  String get settings_mine_login_title => Intl.message('Login', name: 'settings_mine_login_title');

  String get settings_mine_login_subtitle_default => Intl.message('to get access to all the features', name: 'settings_mine_login_subtitle_default');

  String settings_mine_login_subtitle_userinfo(String coinCount, String rank, String level) => Intl.message("coin: $coinCount, rank: $rank, level: $level", args: [coinCount, rank, level], name: 'settings_mine_login_subtitle_userinfo');

  String get settings_mine_menu_msg => Intl.message('Message', name: 'settings_mine_menu_msg');

  String get settings_mine_menu_todo => Intl.message('Todo', name: 'settings_mine_menu_todo');

  String get settings_mine_menu_favorite => Intl.message('Favorite', name: 'settings_mine_menu_favorite');

  String get settings_mine_theme => Intl.message('Custom theme', name: 'settings_mine_theme');

  String get settings_mine_language => Intl.message('Language', name: 'settings_mine_language');

  String get settings_mine_update => Intl.message('Update', name: 'settings_mine_update');

  String get settings_mine_license => Intl.message('License', name: 'settings_mine_license');

  String get settings_mine_about => Intl.message('About', name: 'settings_mine_about');

  String get settings_mine_logout => Intl.message('Logout', name: 'settings_mine_logout');

  String get settings_mine_logout_tip => Intl.message('Are you sure you want to quit your current account?', name: 'settings_mine_logout_tip');

  String get yes => Intl.message('yes', name: 'yes');

  String get cancel => Intl.message('cancel', name: 'cancel');
}

//Locale代理类
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<AppLocalizations> load(Locale locale) {
    //3
    return AppLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
