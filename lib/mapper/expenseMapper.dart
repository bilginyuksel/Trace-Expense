import 'package:trace_expanses/model/expense.dart';

class ExpenseMapper {
  
  String findAll(){
    return "SELECT * FROM EXPENSE";
  }

  String findExpenseById(int id){
    return "SELECT * FROM EXPENSE WHERE id=$id";
  }

  String countExpenses(){
    return "SELECT COUNT(*) FROM EXPENSE";
  }

  String sumPrice(){
    return "SELECT SUM(price) FROM EXPENSE";
  }

  String findAllByCategoryId(int categoryId){
    // TODO : use inner join here.
    return "SELECT * FROM EXPENSE WHERE categoryId=$categoryId";
  }

  String save(Expense expense){
    return "INSERT INTO EXPENSE (price) VALUES (${expense.price})";
  }

}