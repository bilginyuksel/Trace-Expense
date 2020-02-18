import 'baseRepository.dart';

class ExpenseRepository extends BaseSqlRepository{

  String _table = "EXPENSE";
  String _id = "id";
  String _price = "price";
  String _description = "description";
  String _date = "date";
  String _categoryId = "categoryId";
  


  ExpenseRepository(){
    connectDb();
  }

  Future<Map<String, dynamic>> findById(int id) async{
    return (await database.rawQuery("SELECT * FROM $_table WHERE $_id=$id")).single;
  }

  Future<List<Map<String, dynamic>>> findAll() async{
    return await database.rawQuery("SELECT * FROM $_table");
  }

  Future<List<Map<String, dynamic>>> findAllByCategoryId(int categoryId) async{
    // TODO : Use inner join here.
    return await database.rawQuery("SELECT * FROM $_table");
  }

  Future<dynamic> countAll() async{
    return (await database.rawQuery("SELECT COUNT($_price) FROM $_table")).single['COUNT($_price)'];
  }

  Future<dynamic> sumAll() async{
    return (await database.rawQuery("SELECT SUM($_price) FROM $_table")).single['SUM($_price)'];
  }
}