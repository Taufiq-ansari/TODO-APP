import 'package:flutter/material.dart';
import 'package:todoapp/database/sqlite/dbhelper.dart';
import 'package:todoapp/model/todomodel.dart';
import 'package:todoapp/pages/todoaddpage.dart';

class ToDoHomepage extends StatefulWidget {
  const ToDoHomepage({super.key});

  @override
  State<ToDoHomepage> createState() => _ToDoHomepageState();
}

class _ToDoHomepageState extends State<ToDoHomepage> {
  List<TodoModel> todoList = [];
  late DBHelper helper;

  @override
  void initState() {
    super.initState();
    print("initstate called..");
helper = DBHelper.getInstance;
 fetchTodo();
  }

 Future<void> fetchTodo() async {
        print("featch todo printed..");
        todoList = await helper.getAllTodo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     // print(" build function called ${todoList.length}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "TODOAPP",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
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
                    trailing: Row( mainAxisSize: MainAxisSize.min,
                      children: [
                        //edit button
                        IconButton(onPressed: () async{
                          print("update button working...");

                          final prenote = TodoModel( id: newList.id, title:newList.title, description:newList.description);


                         final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoAddpage(todo: prenote,)));
                          if(result != null){
                           await fetchTodo();
                          }
                          setState(() {});
                        },

                           icon: Icon(Icons.edit)),

                        // delete button
                        IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      buttonPadding: EdgeInsets.all(12),
                                      alignment: Alignment.center,

                                      content: Text("Sure you want to delete?"),
                                      title: Text("delete"),
                                      actions: [
                                        TextButton(
                                          onPressed: ()async {
                                            var rowEffected=   await helper.delete(todoList[index].id!);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text("task deleted"),
                                              ),
                                            );
                                           await fetchTodo();
                                            setState(() {

                                              print("$rowEffected");
                                            });
                                          },
                                          child: Text("yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "item is not deleted",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("no"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                setState(() {

                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                      ],
                    ),

                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        shape: CircleBorder(),
        onPressed: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoAddpage(

          ),
          ),
          );
            print(" result :$result");
           if(result != null ){
           await  fetchTodo();
           }
           else{
             print("ERROR : $result");
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
