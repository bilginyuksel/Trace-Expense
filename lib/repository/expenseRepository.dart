import 'package:trace_expanses/model/expense.dart';

import 'baseRepository.dart';

class ExpenseRepository extends BaseSqlRepository{

  static const String _table = "EXPENSE";
  static const String _id = "eid";
  static const String _price = "price";
  static const String _description = "description";
  static const String _date = "date";
  static const String _categoryId = "categoryId";
  static const String _innerJoin = "INNER JOIN CATEGORY ON CATEGORY.cid = $_categoryId";
  


  ExpenseRepository(){
    connectDb();
  }

  Future<Map<String, dynamic>> findById(int id) async{
    return (await database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE $_id=$id")).single;
  }

  Future<List<Map<String, dynamic>>> findAll() async{
    return await database.rawQuery("SELECT * FROM $_table $_innerJoin");
  }

  Future<List<Map<String, dynamic>>> findAllByCategoryId(int categoryId) async{
    return await database.rawQuery("SELECT * FROM $_table $_innerJoin WHERE categoryId=$categoryId");
  }

  Future<dynamic> countAll() async{
    return (await database.rawQuery("SELECT COUNT($_price) FROM $_table")).single['COUNT($_price)'];
  }

  Future<dynamic> sumAll() async{
    return (await database.rawQuery("SELECT SUM($_price) FROM $_table")).single['SUM($_price)'];
  }

  Future<void> save(Expense expense) async{
    await database.insert(_table, expense.toMap());
  }
}