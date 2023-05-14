import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projectioe/HomeScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/appicon.png'),
                height: size.height * 0.55,
                width: size.width * 0.55,
              ),
              Text(
                "IOE",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              Container(
                height: size.height * 0.335,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Everything You Require Related Engineering And Entrance Preparation In A Single App",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
