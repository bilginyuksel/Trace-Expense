/*
servis class for expense operations */
import 'package:trace_expanses/model/expense.dart';

abstract class IExpenseService {
  Future<List<Expense>> getAllExpensesByCategory(int categoryId);
  Future<List<Expense>> getAllExpenses();
  Future<Expense> getExpenseById(int id);
  Future<List<Expense>> getAllExpensesBetweenDateBeforeAndDateAfter(DateTime before, DateTime after);
  Future<List<Expense>> getAllExpensesByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, DateTime before, DateTime after);
  Future<dynamic> sumAllExpensesBetweenDateBeforeAndDateAfter(DateTime before, DateTime after);
  Future<dynamic> sumAllExpensesByCategoryIdAndBetweenDateBeforeAndDateAfter(int categoryId, DateTime before, DateTime after);
}

