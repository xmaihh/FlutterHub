// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static m0(username) => "登录成功，欢迎 ${username}";

  static m1(coinCount, rank, level) => "积分：${coinCount}，排名：${rank}，等级：${level}";

  static m2(version) => "发现新版本 ${version}，是否更新？";

  static m3(retryTime) => "速率限制，请在 ${retryTime} 后重试";

  static m4(username) => "欢迎 ${username}， 注册成功！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "app_name" : MessageLookupByLibrary.simpleMessage("Flutter应用"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "login_btn_forgot_password" : MessageLookupByLibrary.simpleMessage("忘记密码？"),
    "login_btn_login" : MessageLookupByLibrary.simpleMessage("登录"),
    "login_btn_signup" : MessageLookupByLibrary.simpleMessage("去注册"),
    "login_message_welcome_login_successful" : m0,
    "login_no_account" : MessageLookupByLibrary.simpleMessage("还没有帐号？"),
    "login_other_method" : MessageLookupByLibrary.simpleMessage("其他帐号登录"),
    "login_password_label" : MessageLookupByLibrary.simpleMessage("密码"),
    "login_password_validator" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "login_subtitle" : MessageLookupByLibrary.simpleMessage("请输入您的登录凭据"),
    "login_title" : MessageLookupByLibrary.simpleMessage("你好，欢迎回来"),
    "login_username_label" : MessageLookupByLibrary.simpleMessage("用户名"),
    "login_username_validator" : MessageLookupByLibrary.simpleMessage("请输入用户名"),
    "nav_home" : MessageLookupByLibrary.simpleMessage("首页"),
    "nav_login" : MessageLookupByLibrary.simpleMessage("登录"),
    "nav_settings" : MessageLookupByLibrary.simpleMessage("设置"),
    "nav_signup" : MessageLookupByLibrary.simpleMessage("注册"),
    "settings_about" : MessageLookupByLibrary.simpleMessage("关于"),
    "settings_app_license" : MessageLookupByLibrary.simpleMessage("开源许可"),
    "settings_app_version" : MessageLookupByLibrary.simpleMessage("版本"),
    "settings_check_for_updates" : MessageLookupByLibrary.simpleMessage("检查更新"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("语言"),
    "settings_language_auto" : MessageLookupByLibrary.simpleMessage("自动"),
    "settings_mine_about" : MessageLookupByLibrary.simpleMessage("关于"),
    "settings_mine_language" : MessageLookupByLibrary.simpleMessage("多语言"),
    "settings_mine_license" : MessageLookupByLibrary.simpleMessage("开源许可"),
    "settings_mine_login_subtitle_default" : MessageLookupByLibrary.simpleMessage("解锁全部功能，畅享完整体验"),
    "settings_mine_login_subtitle_userinfo" : m1,
    "settings_mine_login_title" : MessageLookupByLibrary.simpleMessage("立即登录"),
    "settings_mine_logout" : MessageLookupByLibrary.simpleMessage("退出登录"),
    "settings_mine_logout_tip" : MessageLookupByLibrary.simpleMessage("确定要退出当前账号吗？"),
    "settings_mine_menu_favorite" : MessageLookupByLibrary.simpleMessage("收藏"),
    "settings_mine_menu_msg" : MessageLookupByLibrary.simpleMessage("消息"),
    "settings_mine_menu_todo" : MessageLookupByLibrary.simpleMessage("待办"),
    "settings_mine_theme" : MessageLookupByLibrary.simpleMessage("个性换肤"),
    "settings_mine_update" : MessageLookupByLibrary.simpleMessage("检查更新"),
    "settings_theme" : MessageLookupByLibrary.simpleMessage("主题"),
    "settings_update_action_cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "settings_update_action_update" : MessageLookupByLibrary.simpleMessage("更新"),
    "settings_update_msg_app_up_to_date" : MessageLookupByLibrary.simpleMessage("您的应用已经是最新版本"),
    "settings_update_msg_check_failed" : MessageLookupByLibrary.simpleMessage("检查更新失败，请稍后再试"),
    "settings_update_msg_new_version_found" : m2,
    "settings_update_msg_rate_limit" : m3,
    "settings_update_title_new_version_available" : MessageLookupByLibrary.simpleMessage("有新版本可用"),
    "signup_already_have_an_account" : MessageLookupByLibrary.simpleMessage("已经有帐号？ "),
    "signup_btn_login" : MessageLookupByLibrary.simpleMessage("去登录"),
    "signup_btn_signup" : MessageLookupByLibrary.simpleMessage("注册"),
    "signup_confirm_password_label" : MessageLookupByLibrary.simpleMessage("确认密码"),
    "signup_confirm_password_validator" : MessageLookupByLibrary.simpleMessage("请输入确认密码"),
    "signup_message_welcome_signup_successful" : m4,
    "signup_password_label" : MessageLookupByLibrary.simpleMessage("密码"),
    "signup_password_mismatch_error" : MessageLookupByLibrary.simpleMessage("两次输入的密码不一致！"),
    "signup_password_validator" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "signup_subtitle" : MessageLookupByLibrary.simpleMessage("创建一个新账号"),
    "signup_title" : MessageLookupByLibrary.simpleMessage("注册帐号"),
    "signup_username_label" : MessageLookupByLibrary.simpleMessage("用户名"),
    "signup_username_validator" : MessageLookupByLibrary.simpleMessage("请输入用户名"),
    "yes" : MessageLookupByLibrary.simpleMessage("确定")
  };
}
