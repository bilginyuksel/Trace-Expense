import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteConnector {

  SqfliteConnector._privateConstructor();
  static final SqfliteConnector instance = SqfliteConnector._privateConstructor();
  Database _database;

  
  Future<Database> get db async {
    if (_database==null) await _connectDb();
    return _database;
  }

  Future<void> kill() async{
    await _close();
  }

  
  Future<void> _connectDb() async{
  
    String realPath = join(await getDatabasesPath(), 'demo.db');
    _database = await openDatabase(realPath, version:1,
      onOpen: (db) async{
        print("Log: Database connection opened !\nPath : $realPath");
        },
      onCreate: (Database db, int version) async{
        print("Log: Real Database Path : $realPath");
        
        await db.execute('CREATE TABLE IF NOT EXISTS CATEGORY (cid INTEGER PRIMARY KEY, title TEXT)');
        await db.execute('CREATE TABLE IF NOT EXISTS EXPENSE (eid INTEGER PRIMARY KEY, description TEXT, price REAL, date TEXT, categoryId INTEGER, FOREIGN KEY (categoryId) REFERENCES CATEGORY(id))');
        await db.execute("CREATE TABLE IF NOT EXISTS SYSTEM (sid INTEGER PRIMARY KEY, code TEXT, title TEXT, data TEXT)");

        DateTime d = DateTime.now();
        await db.insert("SYSTEM", {'code':'DATE','title':'WEEK','data':DateTime(d.year, d.month, d.day).toString()});
        await db.insert("SYSTEM", {'code':'DATE','title':'MONTH','data':DateTime(d.year, d.month, d.day).toString()});
    });
  }

  // Close database connection
  Future<void> _close() async{
    await _database.close();
  }
}