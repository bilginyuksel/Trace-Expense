import 'package:sqflite/sqflite.dart';

class SystemRepository{
  static final String _table = "SYSTEM";
  static final String _title = "title";
  static final String _code = "code";
  static final String _data = "data";
  static final String _id = "sid";
  Database _database ;
 

 SystemRepository(Database db){
   _database = db;
 }

 Future<dynamic> findByCodeAndTitle(String code, String title) async {
   return (await _database.rawQuery("SELECT * FROM $_table WHERE $_code = '$code' AND $_title = '$title'")).single['data'];
 }

 Future<int> updateByCodeAndTitle(String code, String title, String date) async{
   return (await _database.rawUpdate("UPDATE $_table SET $_data = '$date' WHERE $_code = '$code' AND $_title = '$title' "));
 }


}