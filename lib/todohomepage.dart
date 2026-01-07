import 'package:flutter/material.dart';

class ToDoHomepage extends StatefulWidget {
  const ToDoHomepage({super.key});

  @override
  State<ToDoHomepage> createState() => _ToDoHomepageState();
}

class _ToDoHomepageState extends State<ToDoHomepage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  // store a value
  List<Map<String, String>> todoList = [];

  // add function
  void addTask() {
    todoList.add({
      "title": titleController.text,
      "desc": desController.text,
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TODOAPP",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 214, 200, 200)),
              ),
              onPressed: () {
                // onclick to add  note
                addTask();
                titleController.clear();
                desController.clear();
              },
              child: Text(
                "ADD",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(todoList[index]["title"] ?? " "),
                    subtitle: Text(todoList[index]["desc"] ?? " "),
                    trailing: IconButton(
                      onPressed: () {
                        todoList.removeAt(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
