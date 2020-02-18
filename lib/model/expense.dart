import 'category.dart';

class Expense{
  int id;
  Category category;
  String description;
  double price;
  DateTime dateTime;

  Expense(int id, Category category, double price, String description){
    this.id = id;
    this.dateTime = DateTime.now();
    this.category = category;
    this.description = description;
    this.price = price;
  }

  
}


