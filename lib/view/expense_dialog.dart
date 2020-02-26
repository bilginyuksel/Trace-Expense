import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trace_expanses/model/category.dart';
import 'package:trace_expanses/model/expense.dart';


class ExpenseDialogBuilder extends StatefulWidget{
  List<Category> categories;
  Function saveExpense;
  ExpenseDialogBuilder({this.categories, this.saveExpense});
  _ExpenseDialogBuilder createState() => _ExpenseDialogBuilder(this.categories, this.saveExpense);
}

class _ExpenseDialogBuilder extends State<ExpenseDialogBuilder>  {

  int categoryIndex = 0;
  String categoryPickerText = "Pick a category";
  String price = "0";
  String description = "-";
  List<Category> categories;
  Function saveExpense;

  _ExpenseDialogBuilder(this.categories, this.saveExpense);

  CupertinoPicker categoryPicker(){
    return CupertinoPicker.builder(
      itemExtent: 50,
      magnification: 1.2,
      childCount: categories.length,
      onSelectedItemChanged: (int index){
        setState(() {
          categoryIndex = index;
          categoryPickerText = categories[index].title;
        });
      },
      itemBuilder: (_,index) => Text(categories[index].title),);
  
  }

 

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 380,
        // width: 400,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left:15, right:15,top:15, bottom: 5),
              child: Text(
                'Spend Money',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(49, 87, 110, 1)),
              ),
            ),
            Padding(child: Divider(height: 1, color: Colors.black,), padding: EdgeInsets.symmetric(horizontal: 30),),
            Padding(
              padding: EdgeInsets.only(top:30, bottom: 10),
              child: GestureDetector(child: Text(categoryPickerText,style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),),
              onTap: (){
                // Initialization text
                setState(() {
                  categoryPickerText = categories[categoryIndex].title;
                });
                // Show cupertino modal bottom on iphone style.
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:MediaQuery.of(context).copyWith().size.height /3,
                        child: categoryPicker(),);
                  });
              },),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (String t) => description = t,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (String p) => price = p,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: '0.00',
                  suffixText: 'TL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(16),
              child: Text('Spend', style: TextStyle(fontSize: 18,)),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () async{
                await saveExpense(Expense(description: description, price: double.parse(price), category: categories[categoryIndex]));
                Navigator.pop(context);
                
              },
            )
          ],
        ),
      ),
    );
  }
}




