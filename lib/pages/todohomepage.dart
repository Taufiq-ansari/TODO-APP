import 'package:flutter/material.dart';
import 'package:todoapp/database/sqlite/dbhelper.dart';
import 'package:todoapp/pages/todoaddpage.dart';
import '../model/todomodel.dart';


class ToDoHomepage extends StatefulWidget {
  const ToDoHomepage({super.key});

  @override
  State<ToDoHomepage> createState() => _ToDoHomepageState();
}

class _ToDoHomepageState extends State<ToDoHomepage> {
  List<TodoModel> todoList = [];
  late DBHelper helper;





  Color colorChoice(int? priorityColor){
   switch(priorityColor){
     case 1:
       return Colors.grey.shade300;  // high prio

   case 2:
     return Colors.redAccent;       // medium prio

     case 3:
       return Colors.green;         // low prio

       default:
         return Colors.amber;
   }
 }
 // color change by index
 void updatePriority(int index){
    print("===> color change $index");
     todoList[index].priority =todoList[index].priority==3?1:todoList[index].priority+1;
    setState(() {

    });
 }


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
                // final priorityColor = colorChoice(newList.prio);

                return GestureDetector(

                  onTap: ()=>updatePriority(index),
                  child: Card(

                    color: colorChoice(newList.priority),

                    child: ListTile(
                      title: Text(newList.title.toString()),
                      subtitle: Text(newList.description.toString()),
                      trailing: Row( mainAxisSize: MainAxisSize.min,
                        children: [
                          //edit button
                          IconButton(onPressed: () async{
                            print("===> update...");
                            // final prenote = TodoModel( id: newList.id, title:newList.title, description:newList.description);
                            //   final updateId = newList.id;
                            //   if(updateId ==null){
                            //      print("update value not working");
                            //   }

                           final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoAddpage(todo: newList,
                             )));
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


