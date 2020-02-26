import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trace_expanses/model/expense.dart';
import 'package:trace_expanses/repository/db_bind.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';
import 'package:trace_expanses/service/expenseService.dart';
import 'package:trace_expanses/service/expenseServiceImpl.dart';



class ExpensesWidget extends StatefulWidget {

  _Expenses createState() => new _Expenses();
}

// Category, description, price, date

class _Expenses extends State<ExpensesWidget> {

  List<Expense> expenseList = new List();
  static DateTime _today = DateTime.now();
  static DateTime _start = DateTime(_today.year, _today.month, _today.day); 
  static DateTime _end = _start.add(Duration(hours: 24));

  ExpenseRepository _repository;
  IExpenseService _expenseService;

  @override
  void initState(){
  
    SqfliteConnector.instance.db.then((value){
      _repository = ExpenseRepository(value);
      _expenseService = ExpenseServiceImplementation(_repository);

      DateTime today = DateTime.now();
      DateTime pureToday = DateTime(today.year, today.month, today.day);
      
      _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(pureToday, pureToday.add(Duration(hours: 24))).then((value) {
        expenseList = value;
        setState(() { /** build list again */});
      });
    });
    
  }

  Widget listExpenseCard(Expense content){
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left:15, top:10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "${content.category.title}",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
                  Text(
                    "${content.description}",
                    style: TextStyle(fontSize: 15),),
                  Text(
                    "${content.date.day}/${content.date.month}/${content.date.year}-${content.date.hour}:${content.date.minute}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color:Colors.black54),)
                ],
              ),),
            Expanded(
              flex: 1,
              child: Text(
                "${content.price} TL",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            
          ],
        ),
      )
    );
  }


  void _onFilterPressed(){
    showDialog(context: context, builder: (BuildContext context) => FilterDialog()).whenComplete(() async {
      expenseList = await _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(_start, _end);
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left:20, top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Categories : ALL", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                      Text("Start Date : $_start", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                      Text("End Date : $_end", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
                    ],
                  ),
                  IconButton(icon: Icon(Icons.filter_list, color: Colors.black,),iconSize: 30, onPressed: _onFilterPressed, padding: EdgeInsets.only(right:30),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView.builder(
            itemCount: expenseList.length,
            padding: EdgeInsets.all(15),
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index) {
              return listExpenseCard(expenseList[index]);
          }),
          )
        ],
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {

  _FilterDialog createState() => _FilterDialog();
}


class _FilterDialog extends State<FilterDialog>{

  

  void _openDatePickerDialog(int picker){
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      
      return CupertinoDatePicker(
        maximumDate: DateTime.now().add(Duration(days: 30)), 
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        minimumDate: DateTime.now().subtract(Duration(days: 30)),
        onDateTimeChanged: (DateTime t) =>setState(() =>picker==0?_Expenses._start = t:_Expenses._end= t));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 200,
        width: 300,
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Date Start", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                  SizedBox(width: 10,),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child : Row(
                        children: <Widget>[
                          Text("${_Expenses._start.year}/${_Expenses._start.month}/${_Expenses._start.day}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),),
                          IconButton(icon: Icon(Icons.arrow_drop_down), onPressed:() => _openDatePickerDialog(0),)
                        ],
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Text("Date End", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                  SizedBox(width: 18,),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child : Row(
                        children: <Widget>[
                          Text("${_Expenses._end.year}/${_Expenses._end.month}/${_Expenses._end.day}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),),
                          IconButton(icon : Icon(Icons.arrow_drop_down), onPressed: ()=> _openDatePickerDialog(1),)
                        ],
                      )
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}