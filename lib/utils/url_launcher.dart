// lib/utils/url_launcher_util.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// URL启动器工具类
class UrlLauncher {
  /// 打开URL
  ///
  /// [url] 需要打开的URL字符串
  /// [context] BuildContext用于显示错误提示，可选参数
  /// [mode] URL启动模式，默认为PlatformMode.platformDefault
  ///
  /// 返回Future<bool>表示是否成功打开URL
  static Future<bool> openUrl(
    String url, {
    BuildContext? context,
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      // 检查URL是否可以打开
      if (!await canLaunchUrl(uri)) {
        _handleError('无法打开链接: $url', context);
        return false;
      }

      // 尝试打开URL
      final result = await launchUrl(
        uri,
        mode: mode,
      );

      if (!result) {
        _handleError('打开链接失败: $url', context);
        return false;
      }

      return true;
    } catch (e) {
      _handleError('链接错误: $e', context);
      return false;
    }
  }

  /// 打开邮件
  static Future<bool> sendEmail(
    String email, {
    BuildContext? context,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );

    return openUrl(emailUri.toString(), context: context);
  }

  /// 打开电话
  static Future<bool> makePhoneCall(
    String phoneNumber, {
    BuildContext? context,
  }) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    return openUrl(telUri.toString(), context: context);
  }

  /// 错误处理
  static void _handleError(String message, BuildContext? context) {
    debugPrint(message);

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
