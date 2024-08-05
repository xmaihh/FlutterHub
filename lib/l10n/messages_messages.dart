// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(version) => "A new version ${version} is available, do you want to update?";

  static m1(retryTime) => "Rate limit exceeded, please retry after ${retryTime} ";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "app_name" : MessageLookupByLibrary.simpleMessage("FlutterHub"),
    "login_btn_forget_password" : MessageLookupByLibrary.simpleMessage("Forget password?"),
    "login_btn_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "login_btn_signup" : MessageLookupByLibrary.simpleMessage("Signup"),
    "login_no_account" : MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
    "login_other_method" : MessageLookupByLibrary.simpleMessage("Others"),
    "login_password_label" : MessageLookupByLibrary.simpleMessage("Password"),
    "login_password_validator" : MessageLookupByLibrary.simpleMessage("Enter your password"),
    "login_username_label" : MessageLookupByLibrary.simpleMessage("Username"),
    "login_username_validator" : MessageLookupByLibrary.simpleMessage("Enter your username"),
    "nav_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "nav_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "nav_settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "nav_signup" : MessageLookupByLibrary.simpleMessage("Signup"),
    "settings_about" : MessageLookupByLibrary.simpleMessage("About"),
    "settings_app_license" : MessageLookupByLibrary.simpleMessage("License"),
    "settings_app_version" : MessageLookupByLibrary.simpleMessage("Version"),
    "settings_check_for_updates" : MessageLookupByLibrary.simpleMessage("Check for updates"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_language_auto" : MessageLookupByLibrary.simpleMessage("Auto"),
    "settings_theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "settings_update_action_cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "settings_update_action_update" : MessageLookupByLibrary.simpleMessage("Update"),
    "settings_update_msg_app_up_to_date" : MessageLookupByLibrary.simpleMessage("Your application is up to date"),
    "settings_update_msg_check_failed" : MessageLookupByLibrary.simpleMessage("Update check failed, please try again later"),
    "settings_update_msg_new_version_found" : m0,
    "settings_update_msg_rate_limit" : m1,
    "settings_update_title_new_version_available" : MessageLookupByLibrary.simpleMessage("New version available")
  };
}
