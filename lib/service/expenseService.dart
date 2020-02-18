/*
servis class for expense operations */
import 'package:trace_expanses/model/expense.dart';

abstract class IExpenseService {

  Future<List<Expense>> getAllExpensesByCategory(int categoryId);
  Future<List<Expense>> getAllExpenses();
  Future<Expense> getExpenseById(int id);
  Future<List<Expense>> getAllExpenseByDateTime();
  
}

