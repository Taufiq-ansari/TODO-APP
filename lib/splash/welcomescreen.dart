import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/pages/todohomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _image = "assets/todo.png";

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ToDoHomepage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeOut,
            duration: Duration(
              seconds: 2000,
            ),
            top: 90,
            left: 30,
            child: Text(
              "Welcome",
              style: TextStyle(color: Colors.grey, fontSize: 50),
            ),
          ),

          // image
          Positioned(
            top: 230,
            child: Image.asset(
              "assets/image/todo.png",
              height: 350,
              fit: BoxFit.fill,
            ),
          ),

          //  text
          Positioned(
            top: 600,
            left: 25,
            child: Text(
              '''A smart way to manage your daily tasks set goals,
                 track progress, and stay focused.''',
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
