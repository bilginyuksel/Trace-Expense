import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


abstract class BaseSqlRepository{

  Database database;


  // Open database connection
  Future<void> connectDb() async{
  
    String realPath = join(await getDatabasesPath(), 'demo.db');
    database = await openDatabase(realPath, version:1,
      onOpen: (db){
        print("Database connection opened !\nPath : $realPath");
        },
      onCreate: (Database db, int version) async{
        print("Real Database Path : $realPath");
        
        await db.execute('CREATE TABLE CATEGORY (cid INTEGER PRIMARY KEY, title TEXT)');
        await db.execute('CREATE TABLE EXPENSE (eid INTEGER PRIMARY KEY, description TEXT, price REAL, date TEXT, categoryId INTEGER, FOREIGN KEY (categoryId) REFERENCES CATEGORY(id))');
        // Think on system properties.
        // await db.execute("CREATE TABLE SYSTEM (sid INTEGER PRIMARY KEY, code TEXT, title TEXT, status INTEGER)");
    });
  }

  // Close database connection
  Future<void> close() async{
    await database.close();
  }
}

