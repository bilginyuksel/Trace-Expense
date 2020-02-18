import 'category.dart';

class Expense{
  int eid;
  Category category;
  String description;
  double price;
  DateTime date;

  Expense({int eid, Category category, double price, String description}){
    this.eid = eid;
    this.date = DateTime.now();
    this.category = category;
    this.description = description;
    this.price = price;
  }

  Map<String, dynamic> toMap(){
    return {
      "eid":eid,
      "price":price,
      "date":date.toString(),
      "description":description,
      "categoryId": category.cid,
    };
  }

  Expense.fromMap(Map<String, dynamic> map){
    this.eid = map['eid'];
    this.description = map['description'];
    this.price = map['price'];

    // TODO : You have to achieve this category problem
    // You're going to hold the category in the database as a number.
    // So you have to push it as a number but when you try to get this.
    // You have to convert it to real category object.
    this.category = Category(cid: map['categoryId'], title: map['title']);
    this.date = map['date'];
  }
  
  
}


