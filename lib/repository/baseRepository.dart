import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trace_expanses/mapper/categoryMapper.dart';


abstract class BaseSqlRepository{
  // void save();
  // void delete();
  // void update()
  Database database;

  void connectDb() async{
  
    String realPath = join(await getDatabasesPath(), 'demo.db');
    database = await openDatabase(realPath, version:1,
      onOpen: (db){
        print("Database connection opened !");
        print("Path : $realPath");
        },
      onCreate: (Database db, int version) async{
        // When creating the db.
        print("Real Database Path : $realPath");
        await db.execute('CREATE TABLE CATEGORY (id INTEGER PRIMARY KEY, title TEXT)');
        await db.execute('CREATE TABLE EXPENSE (id INTEGER PRIMARY KEY, price REAL)');

    });
  }



  void addCategory() async{
    print("Category adding...");
    await database.rawInsert("INSERT INTO CATEGORY (title) VALUES ('Mesrubat')");
  }

  void getCategories() async {
    print("Categories waiting..");
    List<Map<String,dynamic>> maps = await database.rawQuery("SELECT * FROM CATEGORY");
    maps.forEach((element) {
      print(element);
    });
  }

  void close() async{
    print("Database Closed");
    await database.close();
  }
}

