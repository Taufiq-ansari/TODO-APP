import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/database/sqlite/dbhelper.dart';

import '../model/todomodel.dart';

class ToDoAddpage extends StatefulWidget {
  const ToDoAddpage({super.key, this.todo, });

  final TodoModel? todo;

   // explicite  id for update
 // final int? id;

  @override
  State<ToDoAddpage> createState() => _ToDoAddpageState();
}

class _ToDoAddpageState extends State<ToDoAddpage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

late  DBHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DBHelper.getInstance;
 // prefilled title & description
    if(
    widget.todo != null
    ){
      titleController.text= "${widget.todo!.title}";
      desController.text =  "${widget.todo!.description}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "TODOAPP",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // onclick to add  note
                    final todo = TodoModel( id: widget.todo?.id, title: titleController.text, description: desController.text);
                     print("  desc print : ${desController.text}");
                     // print("$titleController");

                    final uTitle = titleController.text;
                    final uDesc = desController.text;

                    if (uTitle.isNotEmpty && uDesc.isNotEmpty) {
                      try {
                        if(widget.todo==null) {
                        // using model
                            var todoInserted = await helper.addTodo(todo);
                            print(todo);
                            print(todoInserted);
                            Navigator.pop(context, todoInserted);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted successfully")));
                            }
                        else{
                        // for update todo
                          final updatedTodo = await helper.update(widget.todo!.id!, todo);

                          Navigator.pop(context, updatedTodo);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Updated successfully")),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("ERROR : $e"),
                          ),
                        );
                      }
                    }
                    titleController.clear();
                    desController.clear();
                    setState(() {

                    });
                  }
                },
                child: Text(
                 widget.todo==null? "ADD": "update",
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
