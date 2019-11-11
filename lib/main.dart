import 'package:flutter/material.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/login_page.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_route.dart';
import 'package:fluro/fluro.dart';

void main() {
  router.define('home/:data', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new HomePage(params['data'][0]);
      }));
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。
    // 写在组件渲染之后，是为了在渲染后进行set赋值，
    // 覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
//    SystemUiOverlayStyle systemUiOverlayStyle =
//    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
//    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
//        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent[200],
        accentColor: Colors.redAccent[200],
        fontFamily: 'Montserrat',
      ),
    );
  }
}