import 'package:flutter/material.dart';
import 'package:todoapp/pages/todohomepage.dart';
import 'package:todoapp/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.light
      ,
      home: ToDoHomepage(),
    );
  }
}
