import 'package:sqflite/sqflite.dart';
import 'package:trace_expanses/model/category.dart';

class CategoryRepository {

  static final String _table = "CATEGORY";
  static final String _title = "title";
  static final String _id = "cid";
  Database _database ;
 

 CategoryRepository(Database db){
   _database = db;
 }

  Future<List<Map<String, dynamic>>> findAll() async{
    return await _database.rawQuery("SELECT * FROM $_table");
  }

  Future<Map<String, dynamic>> findById(int id) async {
    return (await _database.rawQuery("SELECT * FROM $_table WHERE $_id=$id")).single;
  } 

  Future<Map<String, dynamic>> findByTitle(String title) async {
    return (await _database.rawQuery("SELECT * FROM $_table WHERE $_title='$title'")).single;
  }

  Future<dynamic> countAll() async{
    return (await _database.rawQuery("SELECT COUNT(*) FROM $_table")).single['COUNT(*)'];
  }

  Future<void> save(Category model) async{
    await _database.insert(_table, model.toMap());
  }
  
}