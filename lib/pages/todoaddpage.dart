import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

//color selector ==> ( defined selectedColor as pickerColor)


  Color _selectedColor = Colors.indigo;       //store db color
  Color currentColor = Colors.indigo;         //temp


  // list of colors
  List<Color> colors = [
    Colors.indigo,
    Colors.redAccent,
    Colors.green,
    Colors.yellow,
    Colors.pink,
  ];

  //===> color index
  int colorIndex =-1;

  //===> change color
  void changeColor(Color color){
    currentColor=color;

    setState(() {

    });
  }



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

Row(
  children: [
    ElevatedButton(

        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            minimumSize: Size(30, 30)

        ),
        onPressed: (){

          showDialog(

              context: context, builder: (context){
            return AlertDialog(
              title: Text("select color"),
              content:ColorPicker(pickerColor: currentColor, onColorChanged: changeColor,

                // colorPickerWidth: 200,
              ),  // color picker
              //====> block picker
              // BlockPicker(
              //     pickerColor: currentColor, onColorChanged: changeColor,
              // ),
              actions: [
                ElevatedButton(onPressed: (){

                  // colors.add(currentColor);
                  colorIndex=colors.length-1;
                  colors[colorIndex]=currentColor;

                  _selectedColor = currentColor;

                  Navigator.pop(context);
                  setState(() {

                  });
                }, child: Text("OK"))
              ],
            );

          }
          );
          setState(() {

          });
        }, child: Icon(Icons.brush_outlined)),

    Row(
      children: List.generate(
          colors.length, (int index){
        return GestureDetector(
          onTap:(){
            colorIndex =index;
            _selectedColor =colors[index];
            currentColor =colors[index];
            setState(() {

            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              radius:  13,
              backgroundColor:colors[index],
              child:colorIndex==index? Icon(Icons.done, size: 16,color: Colors.white,
              ): null,
            ),
          ),
        );
      }
      ),
    ),
  ],
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
                    final todo = TodoModel( colorValue:_selectedColor.value ,id: widget.todo?.id, title: titleController.text, description: desController.text,);
                     // print(" ===> desc print : ${desController.text}");
                     // print("===> $titleController");

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

  final beforeupdate = TodoModel( id: widget.todo!.id!,title: titleController.text, description: desController.text, colorValue: currentColor.value);
                        // for update todo
                          final updatedTodo = await helper.update( beforeupdate.id! ,beforeupdate);
                          print(" ==>$updatedTodo ");

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

            // add color picker  to select color by user....=========>
             Row(
                  children: [
                    // Text("Colors",style: TextStyle(fontWeight: FontWeight.bold),),
                    //  SizedBox(
                    //    height: 8.0,
                    //  ),

                    // ColorPicker(
                    //     pickersEnabled: <ColorPickerType,bool>{
                    //       ColorPickerType.accent:false
                    //     },
                    //
                    //     onColorChanged: changeColor,)
//                   Expanded(
// flex: 9,
//                       child: ColorPicker(onColorChanged: changeColor, pickerColor:_selectedColor,
//                       colorPickerWidth:250,
//                       ))
                  ],
                ),

          ],
        ),
      ),
    );
  }
}
