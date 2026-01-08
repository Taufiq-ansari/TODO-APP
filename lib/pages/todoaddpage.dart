import 'package:flutter/material.dart';
import 'package:todoapp/model/todomedel.dart';
import 'package:todoapp/pages/todohomepage.dart';

class ToDoAddpage extends StatefulWidget {
  const ToDoAddpage({super.key});

  @override
  State<ToDoAddpage> createState() => _ToDoAddpageState();
}

class _ToDoAddpageState extends State<ToDoAddpage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  // store a value
  // final List<Map<String, String>> _todoList = [];
  // List<TodoModel> get newlist => _todoList.map<TodoModel>((e) => TodoModel.fromJson(e)).toList();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "TODOAPP",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),

        // add actions buttton to delete task
        //
        // ,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title userinput field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 214, 200, 200)),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 180, 187, 193), width: 2.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please add task";
                  }
                  return null;
                },
              ),
            ),

            // description input field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: desController,

                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 214, 200, 200)),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 180, 187, 193), width: 2.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please add description";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 214, 200, 200)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // onclick to add  note
                    final todo = TodoModel(title: titleController.text, description: desController.text);
                    titleController.clear();
                    desController.clear();

                    Navigator.pop(context, todo);
                    setState(() {});
                  }
                },
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
