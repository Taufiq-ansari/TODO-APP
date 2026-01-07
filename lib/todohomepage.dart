import 'package:flutter/material.dart';

class ToDoHomepage extends StatelessWidget {
   ToDoHomepage({super.key});

  // store a value
  List storeValue = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("TODO-APP")));
  }
}
