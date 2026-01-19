// ignore_for_file: non_constant_identifier_names
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/todomodel.dart';

class DBHelper {
  // creating private constructor
  // DBHelper._();

  //making singleton for  creating  only one instance
  DBHelper._();

  /// variable   for table

  static final String TABLE_Name = "todo";
  static final String COLUMN_NAME_TITLE = "title";
  static final String COLUMN_NAME_DESC = "description";
  static final String COLUMN_ID = "id";

  static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }


  //open database
  Future<Database> openDB() async {
    String databasePath = await getDatabasesPath();

    String dbPath = join(databasePath, "todo.db");
    print("fullpath here : $dbPath");

    return await openDatabase(
      dbPath,
      onCreate: (Database db, int version) {
        print("creating table: $db");
        //  create your all table
        db.execute('''
          CREATE TABLE $TABLE_Name (
          id integer primary key autoincrement,
            title TEXT NOT NULL,
            description TEXT
          )
          ''');
        print("table created successfully...");
      },
      version: 1,
    );
  }

  // all queries
  // insert data

  Future<int> addTodo(TodoModel todo) async {
    final db = await getDB();

    int rowsEffected = await db.insert(
      TABLE_Name,
      todo.toMap(),
    );
    return rowsEffected;
  }

  // getall task
  Future<List<TodoModel>> getAllTodo() async {
    var db = await getDB();

    List<Map<String, dynamic>> mdata = await db.query(TABLE_Name);

    return List.generate(mdata.length, (task) {
      return TodoModel(
        id: mdata[task]["id"],
        title: mdata[task]["title"],
        description: mdata[task]['description'],
      );
    }
    );
  }

    // update task
       Future<int> update(int index, TodoModel todoUpdate)async{
       var db = await getDB();

      int  updateData = await db.update(TABLE_Name, todoUpdate.toMap(),where: 'id=?',whereArgs:[index]);
    return updateData;
     }


    // delete task
    Future<int> delete(int index) async {
      var db = await getDB();
      int deletedData = await db.delete(TABLE_Name, where: "id=?", whereArgs: [index]);
      return deletedData;
    }

}
