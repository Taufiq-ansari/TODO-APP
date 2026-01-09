import 'package:flutter/material.dart';
import 'package:todoapp/pages/todoaddpage.dart';
import 'package:todoapp/pages/todohomepage.dart';
import 'package:todoapp/splash/welcomescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData(),

      themeMode: ThemeMode.dark,
      home: ToDoHomepage(),
    );
  }
}
