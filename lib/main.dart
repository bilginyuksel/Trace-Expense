import 'package:flutter/material.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/repository/db_bind.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';
import 'package:trace_expanses/service/categoryService.dart';
import 'package:trace_expanses/service/categoryServiceImpl.dart';
import 'package:trace_expanses/service/expenseService.dart';
import 'package:trace_expanses/service/expenseServiceImpl.dart';
import 'package:trace_expanses/view/expense_dialog.dart';
import 'package:trace_expanses/view/pie_chart.dart';
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
  ExpenseRepository expenseRepository;
  IExpenseService expenseService;
  CategoryRepository categoryRepository;
  ICategoryService categoryService;


  @override
  void initState() {
    
    SqfliteConnector.instance.db.then((value) {
      categoryRepository = new CategoryRepository(value);
      expenseRepository = new ExpenseRepository(value);

      expenseService = new ExpenseServiceImplementation(expenseRepository);
      categoryService = new CategoryServiceImpl(categoryRepository);

      setState(() {
        // If any data need's to load.
      });


    });
  }

  void _incrementCounter() async{

    List<Expense> expenses = await expenseService.getAllExpenses();
    expenses.forEach((element) {
      print(element);
    });
    
    // Build expense creation dialog to save your expense.
    ExpenseDialogBuilder builder = new ExpenseDialogBuilder(categories : await categoryService.getAllCategories(), saveExpense: expenseRepository.save,);
    showDialog(context: context, builder: (BuildContext context) {return builder;});


    setState(() {
      _counter++;
    //   showDatePicker(context: context,
    //     initialDate: DateTime.now().subtract(Duration(days: 99)),
    //     firstDate: DateTime.now().subtract(Duration(days: 100)),
    //     lastDate: DateTime.now());

    });
  }

  GestureDetector optionCard(String day, dynamic func){
    return GestureDetector(
      onTap: func,
      child: Card(
        elevation: 5,
        child: Padding(
          child: Text(
            day,
            style:TextStyle(
              fontSize: 16
            ),
            ),
          padding: EdgeInsets.all(10),
        ),
        margin: EdgeInsets.all(10),
      ),
    );
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
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                optionCard("Today",()=>print("This day")),
                optionCard("Week",()=>print("This week")),
                optionCard("Month",()=>print("This Month")),
              ],
            ),
            Expanded(child: DatumLegendWithMeasures(  animate: true,), flex: 1,),
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
