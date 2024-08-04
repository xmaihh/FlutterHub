import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hub/utils/app_version.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/widgets/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/global.dart';

/// 未经身份验证的请求的速率限制是每小时 60 个请求
///
/// 更多信息请参阅：
/// [GitHub API 速率限制文档](https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api?apiVersion=2022-11-28#primary-rate-limit-for-unauthenticated-users)
///
Future<void> checkUpdate(BuildContext context, {bool manualCheck = false}) async {
  //限制每小时请求次数
  print(Global.lastShowUpdate);
  final lan = WanLocalizations.of(context);
  if ((DateTime.now().difference(Global.lastShowUpdate)) < const Duration(hours: 1)) {
    final retryTime = Global.lastShowUpdate.add(const Duration(hours: 1));
    final retryTimeFormatted = '${retryTime.hour}:${retryTime.minute.toString().padLeft(2, '0')}';

    if (manualCheck) {
      showSnackBar(context, lan.settings_update_msg_rate_limit(retryTimeFormatted));
    }

    return;
  }
  Global.lastShowUpdate = DateTime.now();
  print(Global.lastShowUpdate);
  // 获取当前应用版本
  final currentVersion = await getAppVersion();
  print("currentVersion:$currentVersion");
  // 从服务器获取最新版本信息
  Response response;
  try {
    response = await Dio().get("https://api.github.com/repos/xmaihh/FlutterHub/releases/latest");
    if (response.statusCode == 200) {
      String latestVersion = response.data['tag_name'].toString();
      print("latestVersion: $latestVersion");
      final downloadUrl = response.data['html_url'];
      print(response.data['body'].toString());
      if (latestVersion != currentVersion) {
        // 有新版本可用
        if (context.mounted) {
          showUpdateDialog(context, latestVersion, downloadUrl);
        }
      } else if (manualCheck) {
        // 如果是手动检查且没有更新
        if (context.mounted) {
          showSnackBar(context, lan.settings_update_msg_app_up_to_date);
        }
      }
    } else {
      throw Exception('Failed to load version info');
    }
  } catch (e) {
    print('Error checking for updates: $e');
    if (manualCheck && context.mounted) {
      showSnackBar(context, lan.settings_update_msg_check_failed);
    }
  }
}

void showUpdateDialog(BuildContext context, String version, String downloadUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var lan = WanLocalizations.of(context);
      return AlertDialog(
        title: Text(lan.settings_update_title_new_version_available),
        content: Text(lan.settings_update_msg_new_version_found(version)),
        actions: <Widget>[
          TextButton(
            child: Text(lan.settings_update_action_cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(lan.settings_update_action_update),
            onPressed: () {
              launchUrl(Uri.parse(downloadUrl), mode: LaunchMode.externalApplication);
            },
          ),
        ],
      );
    },
  );
}
