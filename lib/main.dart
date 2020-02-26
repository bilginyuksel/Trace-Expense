import 'package:flutter/material.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/repository/db_bind.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';
import 'package:trace_expanses/repository/systemRepository.dart';
import 'package:trace_expanses/service/categoryService.dart';
import 'package:trace_expanses/service/categoryServiceImpl.dart';
import 'package:trace_expanses/service/expenseService.dart';
import 'package:trace_expanses/service/expenseServiceImpl.dart';
import 'package:trace_expanses/view/expense_dialog.dart';
import 'package:trace_expanses/view/ham.dart';
import 'package:trace_expanses/view/pie_chart.dart';
import 'package:trace_expanses/view/settings.dart';
import 'model/category.dart';
import 'model/expense.dart';


void main() => runApp(MyApp());


class SystemProperties {
  static DateTime weekStart = DateTime.now();
  static DateTime monthStart = DateTime.now();
}

enum System{
  DAY,WEEK,MONTH
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
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
  int _currentIndex = 0;
  ExpenseRepository expenseRepository;
  IExpenseService expenseService;
  CategoryRepository categoryRepository;
  ICategoryService categoryService;

  final List<Widget> _children = [
    Dashboard(),
    ExpensesWidget(),
    Settings(),
  ];

  final List<String> _titles = [
    "Dashboard",
    "Expensones",
    "Settings"
  ];



  @override
  void initState() {
    
    SqfliteConnector.instance.db.then((value) {
      
      categoryRepository = new CategoryRepository(value);
      expenseRepository = new ExpenseRepository(value);

      
      expenseService = new ExpenseServiceImplementation(expenseRepository);
      categoryService = new CategoryServiceImpl(categoryRepository);

  


    });
  }


  void _bottomNavigationOnTap(int index) async {
    

    setState(() {
      _currentIndex = index;
    });
  }

  void _incrementCounter() async{
    
    // Build expense creation dialog to save your expense.
    ExpenseDialogBuilder builder = new ExpenseDialogBuilder(categories : await categoryService.getAllCategories(), saveExpense: expenseRepository.save,);
    showDialog(context: context, builder: (BuildContext context) {return builder;});

    setState(() {

    });
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex], style: TextStyle(fontSize: 20),),
        backgroundColor: Colors.blueGrey,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => _bottomNavigationOnTap(index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text("Dashboard")),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Expense")),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("Settings"))
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black54,
        elevation: 5,
        selectedFontSize: 14,
        currentIndex: _currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.category),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class Dashboard extends StatefulWidget {

  _Dashboard createState() => new _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  double _currentExpense = 0;
  List<Expense> expenseList = new List();
  List<Category> categoryList = new List();

  ExpenseRepository _expenseRepository;
  IExpenseService _expenseService ;
  CategoryRepository _categoryRepository;
  ICategoryService _categoryService;
  SystemRepository _systemRepository;


  @override
  void initState(){
    SqfliteConnector.instance.db.then((value) {
      _expenseRepository = new ExpenseRepository(value);
      _expenseService = new ExpenseServiceImplementation(_expenseRepository);
      _categoryRepository = new CategoryRepository(value);
      _systemRepository = new SystemRepository(value);
      _categoryService = new CategoryServiceImpl(_categoryRepository);


      initializeAllData().then((value) => setState(()=>print("All Set")));
      
    });
  }

  Future<void> initializeAllData() async{

    DateTime dateTimeNow = DateTime.now();
    DateTime pureDay = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    
    categoryList = await _categoryService.getAllCategories();
    expenseList = await _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(pureDay, pureDay.add(Duration(hours: 24)));
    _currentExpense = await _expenseRepository.sumAllBetweenDateBeforeAndDateAfter(pureDay.toString(), pureDay.add(Duration(hours: 24)).toString());  
    _currentExpense = _currentExpense==null?0:_currentExpense;  
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
    return Center(
        child:  Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                optionCard("Today",
                () async{
                  DateTime dateTimeNow = DateTime.now();
                  DateTime pureDay = DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);

                  expenseList = await _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(pureDay, pureDay.add(Duration(hours: 24)));
                  _currentExpense = await _expenseRepository.sumAllBetweenDateBeforeAndDateAfter(pureDay.toString(), pureDay.add(Duration(hours: 24)).toString());
                  _currentExpense = _currentExpense==null?0:_currentExpense; 
                  setState(() {});
                }),
                optionCard("Week",
                () async{
                  SystemProperties.weekStart = DateTime.parse(await _systemRepository.findByCodeAndTitle("DATE", "WEEK"));
                  _currentExpense = await _expenseService.sumAllExpensesBetweenDateBeforeAndDateAfter(SystemProperties.weekStart,SystemProperties.weekStart.add(Duration(days: 7)));
                  _currentExpense = _currentExpense==null?0:_currentExpense;
                  expenseList = await _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(SystemProperties.weekStart, SystemProperties.weekStart.add(Duration(days: 7)));
                  setState(() {});
                }),
                optionCard("Month",
                () async {
                  SystemProperties.monthStart = DateTime.parse(await _systemRepository.findByCodeAndTitle("DATE", "MONTH"));
                  _currentExpense = await _expenseService.sumAllExpensesBetweenDateBeforeAndDateAfter(SystemProperties.monthStart,SystemProperties.monthStart.add(Duration(days: 30)));
                  _currentExpense = _currentExpense==null?0:_currentExpense;
                  expenseList = await _expenseService.getAllExpensesBetweenDateBeforeAndDateAfter(SystemProperties.monthStart, SystemProperties.monthStart.add(Duration(days:30)));
                  setState(() {});
                }),
              ],
            ),
            Expanded(
              child: Container(
                child: Center(
                  child : Card(
                    child: Padding(
                      child: Text("Expenses : $_currentExpense TL", style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.w400),),
                      padding: EdgeInsets.symmetric(vertical :15, horizontal: 24),
                    ),
                    elevation: 3,
                    color: Color.fromRGBO(49, 87, 110, 1),
                    margin: EdgeInsets.only(bottom: 10),
                  )
                ),
              ),flex:1),
            Text("Expenses according to categories", style: TextStyle(fontSize: 16, color: Color.fromRGBO(49, 87, 110, 1)),),
            Expanded(child: DatumLegendWithMeasures(categoryList, expenseList, animate: true,), flex: 2,),
            SizedBox(height: 20,),
            Text("Expenses according to dates",style: TextStyle(fontSize: 16, color: Color.fromRGBO(49, 87, 110, 1)),),
            Expanded(
              child: Padding(padding:EdgeInsets.only(left:20, right: 20, bottom: 30), 
              child: DateTimeComboLinePointChart(expenseList ,animate: true,)), flex: 2,),
         
          ],
        ),
      );
  }
}