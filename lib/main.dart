import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projectioe/HomeScreen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = window.physicalSize.width;
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(0, 21, 79, 1));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        fontFamily: "Exo2",
      ),
      home: HomeScreen(),
    );
  }
}
