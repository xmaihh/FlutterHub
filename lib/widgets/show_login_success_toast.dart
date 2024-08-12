import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';

void showLoginSuccessToast({required String title, String? subTitle}) {
  BotToast.showSimpleNotification(
    title: title,
    subTitle: subTitle,
    duration: Duration(seconds: 2),
    align: Alignment.bottomCenter,
  );
}
