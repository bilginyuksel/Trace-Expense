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
    this.category = Category(cid: map['categoryId'], title: map['title']);
    this.date = DateTime.parse(map['date']);
  }
  
  @override
  String toString() {
    return "{Eid:$eid,\nCategory:$category,\nDate:$date,\nDescription:$description,\nPrice:$price}";
  }
}


