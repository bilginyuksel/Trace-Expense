import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/repository/db_bind.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';
import 'package:trace_expanses/service/categoryService.dart';
import 'package:trace_expanses/service/categoryServiceImpl.dart';
import 'package:trace_expanses/service/expenseService.dart';
import 'package:trace_expanses/service/expenseServiceImpl.dart';

import 'model/category.dart';
import 'model/expense.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Exponenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  void _incrementCounter() async{

    // ExpenseRepository _expenseRepository = new ExpenseRepository();
    // await _expenseRepository.connectDb();
    // IExpenseService expenseService = new ExpenseServiceImplementation(_expenseRepository);
    // DateTime before = DateTime.parse("2020-02-18 22:56:59.469036");
    // DateTime after = DateTime.parse("2020-02-18 22:56:59.502100");
    // List<Expense> expenses = await expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(before, after);
    // expenses.forEach((element) {
    //   print(element);
    // });

    // Database db = await SqfliteConnector.instace.db;
    

   

    setState(() {
      _counter++;
    //   showDatePicker(context: context,
    //     initialDate: DateTime.now().subtract(Duration(days: 99)),
    //     firstDate: DateTime.now().subtract(Duration(days: 100)),
    //     lastDate: DateTime.now());

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.home),
            
            Text(
              'Huseyin:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
