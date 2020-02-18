import 'package:trace_expanses/model/expense.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';

import 'expenseService.dart';

class ExpenseServiceImplementation implements IExpenseService{

  ExpenseRepository _expenseRepository;
  ExpenseServiceImplementation(this._expenseRepository);

  @override
  Future<List<Expense>> getAllExpenseByDateTime() {
    // TODO: implement getAllExpenseByDateTime
    throw UnimplementedError();
  }

  @override
  Future<List<Expense>> getAllExpenses() async{
    
    List<Expense> expenses = new List();
    List<Map<String, dynamic>> expensesMaps = await _expenseRepository.findAll();
    expensesMaps.forEach((element) {
      expenses.add(Expense.fromMap(element));
    });

    return expenses;
  }

  @override
  Future<List<Expense>> getAllExpensesByCategory(int categoryId) async {
    
    List<Expense> expenses = new List();
    List<Map<String, dynamic>> expensesMap = await _expenseRepository.findAllByCategoryId(categoryId);
    expensesMap.forEach((element) {
      expenses.add(Expense.fromMap(element));
    });

    return expenses;
  }

  @override
  Future<Expense> getExpenseById(int id) async {
    return Expense.fromMap(await _expenseRepository.findById(id));
  }


}