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

  static m0(statusCode) => "Bad response: ${statusCode}";

  static m1(error) => "An error has occurred. ${error}";

  static m2(username) => "Login successful, ${username}. Welcome back!";

  static m3(coinCount, rank, level) => "coin: ${coinCount}, rank: ${rank}, level: ${level}";

  static m4(version) => "A new version ${version} is available, do you want to update?";

  static m5(retryTime) => "Rate limit exceeded, please retry after ${retryTime} ";

  static m6(username) => "Welcome ${username}, signup successful!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "app_name" : MessageLookupByLibrary.simpleMessage("FlutterHub"),
    "cancel" : MessageLookupByLibrary.simpleMessage("cancel"),
    "dio_exception_bad_response" : m0,
    "dio_exception_cancel" : MessageLookupByLibrary.simpleMessage("Request cancelled"),
    "dio_exception_default" : MessageLookupByLibrary.simpleMessage("Unknown error occurred"),
    "dio_exception_error_dialog_ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "dio_exception_error_dialog_title" : MessageLookupByLibrary.simpleMessage("Error"),
    "dio_exception_general_error" : m1,
    "dio_exception_receive_timeout" : MessageLookupByLibrary.simpleMessage("Connection timeout"),
    "favorite_page_edit_bookmark" : MessageLookupByLibrary.simpleMessage("Edit Bookmark"),
    "favorite_page_edit_bookmark_cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "favorite_page_edit_bookmark_confirm" : MessageLookupByLibrary.simpleMessage("Ok"),
    "favorite_page_edit_bookmark_link" : MessageLookupByLibrary.simpleMessage("Link"),
    "favorite_page_edit_bookmark_name" : MessageLookupByLibrary.simpleMessage("Name"),
    "favorite_page_favorites" : MessageLookupByLibrary.simpleMessage("Favorites"),
    "favorite_page_my_bookmarks" : MessageLookupByLibrary.simpleMessage("My Bookmarks"),
    "favorite_page_my_favorites" : MessageLookupByLibrary.simpleMessage("My Favorites"),
    "favorite_page_no_bookmarks" : MessageLookupByLibrary.simpleMessage("No Bookmarks"),
    "favorite_page_no_favorites" : MessageLookupByLibrary.simpleMessage("No Favorites"),
    "favorite_page_refresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "home_page_added_to_favorites" : MessageLookupByLibrary.simpleMessage("Added to favorites"),
    "home_page_article_on_top" : MessageLookupByLibrary.simpleMessage("Top"),
    "home_page_favorite_removed" : MessageLookupByLibrary.simpleMessage("Removed."),
    "home_page_latest_articles" : MessageLookupByLibrary.simpleMessage("Latest Articles"),
    "home_page_no_more_data" : MessageLookupByLibrary.simpleMessage("No more data"),
    "home_page_search" : MessageLookupByLibrary.simpleMessage("Search..."),
    "login_btn_forgot_password" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "login_btn_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "login_btn_signup" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "login_message_welcome_login_successful" : m2,
    "login_no_account" : MessageLookupByLibrary.simpleMessage("Don\'t have an account? "),
    "login_other_method" : MessageLookupByLibrary.simpleMessage("Or"),
    "login_password_label" : MessageLookupByLibrary.simpleMessage("Password"),
    "login_password_validator" : MessageLookupByLibrary.simpleMessage("Enter your password"),
    "login_subtitle" : MessageLookupByLibrary.simpleMessage("Enter your credential to login"),
    "login_title" : MessageLookupByLibrary.simpleMessage("Welcome Back"),
    "login_username_label" : MessageLookupByLibrary.simpleMessage("Username"),
    "login_username_validator" : MessageLookupByLibrary.simpleMessage("Enter your username"),
    "message_page_message" : MessageLookupByLibrary.simpleMessage("Message"),
    "message_page_no_read_message" : MessageLookupByLibrary.simpleMessage("No messages"),
    "message_page_no_unread_message" : MessageLookupByLibrary.simpleMessage("No messages"),
    "message_page_read_message" : MessageLookupByLibrary.simpleMessage("Message read"),
    "message_page_refresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "message_page_unread_message" : MessageLookupByLibrary.simpleMessage("Message unread"),
    "nav_home" : MessageLookupByLibrary.simpleMessage("Home"),
    "nav_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "nav_settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "nav_signup" : MessageLookupByLibrary.simpleMessage("Signup"),
    "settings_about" : MessageLookupByLibrary.simpleMessage("About"),
    "settings_app_license" : MessageLookupByLibrary.simpleMessage("License"),
    "settings_app_version" : MessageLookupByLibrary.simpleMessage("Version"),
    "settings_check_for_updates" : MessageLookupByLibrary.simpleMessage("Check for updates"),
    "settings_code" : MessageLookupByLibrary.simpleMessage("Code"),
    "settings_issues" : MessageLookupByLibrary.simpleMessage("Issue"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_language_auto" : MessageLookupByLibrary.simpleMessage("Auto"),
    "settings_mine_about" : MessageLookupByLibrary.simpleMessage("About"),
    "settings_mine_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_mine_license" : MessageLookupByLibrary.simpleMessage("License"),
    "settings_mine_login_subtitle_default" : MessageLookupByLibrary.simpleMessage("to get access to all the features"),
    "settings_mine_login_subtitle_userinfo" : m3,
    "settings_mine_login_title" : MessageLookupByLibrary.simpleMessage("Login"),
    "settings_mine_logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settings_mine_logout_tip" : MessageLookupByLibrary.simpleMessage("Are you sure you want to quit your current account?"),
    "settings_mine_menu_favorite" : MessageLookupByLibrary.simpleMessage("Favorite"),
    "settings_mine_menu_msg" : MessageLookupByLibrary.simpleMessage("Message"),
    "settings_mine_menu_todo" : MessageLookupByLibrary.simpleMessage("Todo"),
    "settings_mine_theme" : MessageLookupByLibrary.simpleMessage("Custom theme"),
    "settings_mine_update" : MessageLookupByLibrary.simpleMessage("Update"),
    "settings_theme" : MessageLookupByLibrary.simpleMessage("Theme"),
    "settings_update_action_cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "settings_update_action_update" : MessageLookupByLibrary.simpleMessage("Update"),
    "settings_update_msg_app_up_to_date" : MessageLookupByLibrary.simpleMessage("Your application is up to date"),
    "settings_update_msg_check_failed" : MessageLookupByLibrary.simpleMessage("Update check failed, please try again later"),
    "settings_update_msg_new_version_found" : m4,
    "settings_update_msg_rate_limit" : m5,
    "settings_update_title_new_version_available" : MessageLookupByLibrary.simpleMessage("New version available"),
    "signup_already_have_an_account" : MessageLookupByLibrary.simpleMessage("Already have an account? "),
    "signup_btn_login" : MessageLookupByLibrary.simpleMessage("Login"),
    "signup_btn_signup" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "signup_confirm_password_label" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "signup_confirm_password_validator" : MessageLookupByLibrary.simpleMessage("Enter your confirm password"),
    "signup_message_welcome_signup_successful" : m6,
    "signup_password_label" : MessageLookupByLibrary.simpleMessage("Password"),
    "signup_password_mismatch_error" : MessageLookupByLibrary.simpleMessage("Passwords do NOT match!"),
    "signup_password_validator" : MessageLookupByLibrary.simpleMessage("Enter your password"),
    "signup_subtitle" : MessageLookupByLibrary.simpleMessage("Create your account"),
    "signup_title" : MessageLookupByLibrary.simpleMessage("Sign up"),
    "signup_username_label" : MessageLookupByLibrary.simpleMessage("Username"),
    "signup_username_validator" : MessageLookupByLibrary.simpleMessage("Enter your username"),
    "todo_page_add_sheet_hint_text" : MessageLookupByLibrary.simpleMessage("I have to..."),
    "todo_page_add_sheet_title_edit_todo" : MessageLookupByLibrary.simpleMessage("Edit Todo"),
    "todo_page_add_sheet_title_new_todo" : MessageLookupByLibrary.simpleMessage("New Todo"),
    "todo_page_empty_todos" : MessageLookupByLibrary.simpleMessage("There\'s nothing here."),
    "todo_page_empty_todos_refresh" : MessageLookupByLibrary.simpleMessage("refresh"),
    "todo_page_search_sheet_hint_text" : MessageLookupByLibrary.simpleMessage("Search for todo..."),
    "todo_page_search_sheet_title_search" : MessageLookupByLibrary.simpleMessage("Search *"),
    "todo_page_todo" : MessageLookupByLibrary.simpleMessage("TODO"),
    "yes" : MessageLookupByLibrary.simpleMessage("yes")
  };
}
