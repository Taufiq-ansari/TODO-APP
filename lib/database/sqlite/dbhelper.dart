// ignore_for_file: non_constant_identifier_names
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // creating private constructor
  // DBHelper._();

  //making singleton for  creating  only one instance
  // DBHelper._();

  /// variable   for table

  static final String TABLE_Name = "todo";
  static final String COLUMN_NAME_TITLE = "title";
  static final String COLUMN_NAME_DESC = "description";

  // static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    String dirPath = await getDatabasesPath();

    String dbPath = join(dirPath, "TODO.db");
    print("fullpath here : $dbPath");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        print("creating table: $db");
        //  create your all table
        db.execute('''
          CREATE TABLE $TABLE_Name (
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

  Future<bool> addTodo({required String tTitle, required String dDescription}) async {
    var db = await getDB();

    int rows = await db.insert(TABLE_Name, {
      COLUMN_NAME_TITLE: tTitle,
      COLUMN_NAME_DESC: dDescription,
    });
    return rows > 0;
  }

  Future<List<Map<String, dynamic>>> getAllTodo() async {
    var db = await getDB();

    List<Map<String, dynamic>> mdata = await db.query(TABLE_Name);

    return mdata;
  }
}
