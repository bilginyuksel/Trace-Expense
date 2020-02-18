import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


abstract class BaseSqlRepository{

  Database database;


  // Open database connection
  Future<void> connectDb() async{
  
    String realPath = join(await getDatabasesPath(), 'demo.db');
    database = await openDatabase(realPath, version:1,
      onOpen: (db){
        print("Database connection opened !");
        print("Path : $realPath");
        },
      onCreate: (Database db, int version) async{
        // When creating the db.
        print("Real Database Path : $realPath");
        await db.execute('CREATE TABLE CATEGORY (cid INTEGER PRIMARY KEY, title TEXT)');
        await db.execute('CREATE TABLE EXPENSE (eid INTEGER PRIMARY KEY, description TEXT, price REAL, date TEXT, categoryId INTEGER, FOREIGN KEY (categoryId) REFERENCES CATEGORY(id))');

    });
  }

  // Close database connection
  Future<void> close() async{
    print("Database Closed");
    await database.close();
  }
}

