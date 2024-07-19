import 'package:flutter/material.dart';
import 'package:flutter_compass/routes/home_page.dart';

void main()  => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.blueAccent[200],
        fontFamily: 'Montserrat'
      ),
    );
  }
}

