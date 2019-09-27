import 'package:flutter/material.dart';
import 'package:flutter_app/login_page.dart';

void main() => runApp(MyApp());

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