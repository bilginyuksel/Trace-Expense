import 'package:trace_expanses/model/expense.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';

import 'expenseService.dart';

class ExpenseServiceImplementation implements IExpenseService{

  ExpenseRepository _expenseRepository;
  ExpenseServiceImplementation(this._expenseRepository);

  @override
  Future<List<Expense>> getAllExpensesBetweenDateBeforeAndDateAfter(DateTime before, DateTime after) async { 

    List<Expense> expenses = new List();
    List<Map<String, dynamic>> expensesMaps = await _expenseRepository.findAllBetweenDateBeforeAndDateAfter(before.toString(), after.toString());
    expensesMaps.forEach((element) {
      expenses.add(Expense.fromMap(element));
    });

    return expenses;
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

  @override
  Future<dynamic> sumAllExpensesBetweenDateBeforeAndDateAfter(DateTime before, DateTime after) async {
    return await _expenseRepository.sumAllBetweenDateBeforeAndDateAfter(before.toString(), after.toString());
  }

  @override
  Future sumAllExpensesByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, DateTime before, DateTime after) async {
    return await _expenseRepository.sumAllByCategoryIdAndBetweenDateBeforeAndDateAfter(categoryId, before.toString(), after.toString());
  }

  @override
  Future<List<Expense>> getAllExpensesByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, DateTime before, DateTime after) async {
    List<Map<String, dynamic>> expensesMaps = await _expenseRepository.findAllByCategoryIdAndBetweenDateBeforeAndDateAfter(categoryId, before.toString(), after.toString());
    List<Expense> expenses = new List();
    expensesMaps.forEach((element) {
      expenses.add(Expense.fromMap(element));
    });

    return expenses;
  }


}