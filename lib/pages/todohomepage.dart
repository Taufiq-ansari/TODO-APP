// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todoapp/model/todomedel.dart';
import 'package:todoapp/pages/todoaddpage.dart';

class ToDoHomepage extends StatefulWidget {
  ToDoHomepage({super.key});

  @override
  State<ToDoHomepage> createState() => _ToDoHomepageState();
}

class _ToDoHomepageState extends State<ToDoHomepage> {
  final List<TodoModel> todoList = [];
  @override
  Widget build(BuildContext context) {
    print("${todoList.length}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "TODOAPP",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      body: todoList.isEmpty
          ? Center(
              child: Text(
                "no task ",
                style: TextStyle(color: Colors.grey, fontSize: 34),
              ),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final newList = todoList[index];

                return Card(
                  child: ListTile(
                    title: Text(newList.title.toString()),
                    subtitle: Text(newList.description.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        todoList.removeAt(index);
                        setState(() {
                          print("task deleted $index");
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        shape: CircleBorder(),
        onPressed: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoAddpage()));
          if (result != null && result is TodoModel) {
            todoList.add(result);
          }
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
