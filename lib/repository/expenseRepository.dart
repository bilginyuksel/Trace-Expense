import 'package:sqflite/sqflite.dart';
import 'package:trace_expanses/model/expense.dart';


class ExpenseRepository{

  static const String _table = "EXPENSE";
  static const String _id = "eid";
  static const String _price = "price";
  static const String _description = "description";
  static const String _date = "date";
  static const String _categoryId = "categoryId";
  static const String _innerJoin = "INNER JOIN CATEGORY ON CATEGORY.cid = $_categoryId";
  Database _database;

  ExpenseRepository(Database db) {
    _database = db;
  }


  Future<Map<String, dynamic>> findById(int id) async{
    return (await _database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE $_id=$id")).single;
  }

  Future<List<Map<String, dynamic>>> findAll() async{
    return await _database.rawQuery("SELECT * FROM $_table $_innerJoin");
  }

  Future<List<Map<String, dynamic>>> findAllByCategoryId(int categoryId) async{
    return await _database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE categoryId=$categoryId");
  }

  Future<List<Map<String, dynamic>>> findAllBetweenDateBeforeAndDateAfter(String before, String after) async{
    return await _database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE $_date BETWEEN '$before' AND '$after'");
  }

  Future<List<Map<String, dynamic>>> findAllByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, String before, String after) async{
    return await _database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE $_categoryId = $categoryId AND $_date BETWEEN '$before' AND '$after'");
  }

  Future<dynamic> sumAll() async{
    return (await _database.rawQuery("SELECT SUM($_price) FROM $_table")).single['SUM($_price)'];
  }

  Future<dynamic> sumAllByCategoryId(int categoryId) async {
    return (await _database.rawQuery("SELECT SUM($_price) FROM $_table WHERE $_categoryId = $categoryId")).single['SUM($_price)'];
  } 

  Future<dynamic> sumAllBetweenDateBeforeAndDateAfter(String before, String after) async{
    return (await _database.rawQuery("SELECT SUM($_price) FROM $_table WHERE $_date BETWEEN '$before' AND '$after'")).single['SUM($_price)'];
  }

  Future<dynamic> sumAllByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, String before, String after) async {
    return (await _database.rawQuery("SELECT SUM($_price) FROM $_table WHERE $_categoryId = $categoryId AND $_date BETWEEN '$before' AND '$after'")).single['SUM($_price)'];
  }

  Future<dynamic> countAll() async{
    return (await _database.rawQuery("SELECT COUNT($_price) FROM $_table")).single['COUNT($_price)'];
  }
 



  Future<void> save(Expense expense) async{
    await _database.insert(_table, expense.toMap());
  }
}