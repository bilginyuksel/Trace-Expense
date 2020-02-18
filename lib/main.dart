import 'package:flutter/material.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/repository/expenseRepository.dart';
import 'package:trace_expanses/service/categoryService.dart';
import 'package:trace_expanses/service/categoryServiceImpl.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

    // CategoryRepository _categoryRepository = new CategoryRepository();
    // await _categoryRepository.connectDb();
    // ICategoryService _categoryService = new CategoryServiceImpl(_categoryRepository);
    

    // CategoryRepository _categoryRepository = CategoryRepository();
    // await _categoryRepository.connectDb();
    // await _categoryRepository.save(Category(title: "Mesrubat"));
    // await _categoryRepository.save(Category(title: "Ev"));
    // await _categoryRepository.save(Category(title: "Ulasim"));
    // await _categoryRepository.save(Category(title: "Egitim"));
    // await _categoryRepository.save(Category(title: "Eglence"));
    // await _categoryRepository.save(Category(title: "Yemek"));
    // (await _categoryRepository.findAll()).forEach((element) {
    //   print(element.toString());
    // });
    // print((await _categoryRepository.countAll()));
    // await _categoryRepository.close();

    // ExpenseRepository _expenseRepository = ExpenseRepository();
    // await _expenseRepository.connectDb();
    // await _expenseRepository.save(Expense(category: Category(cid: 1,title: "-"),description: "-",price: 32.29));
    // await _expenseRepository.save(Expense(category: Category(cid: 2,title: "-"),description: "-",price: 22.74));
    // await _expenseRepository.save(Expense(category: Category(cid: 2,title: "-"),description: "-",price: 10.11));
    // await _expenseRepository.save(Expense(category: Category(cid: 2,title: "-"),description: "-",price: 31.22));
    // await _expenseRepository.save(Expense(category: Category(cid: 3,title: "-"),description: "-",price: 15.76));
    // await _expenseRepository.save(Expense(category: Category(cid: 5,title: "-"),description: "-",price: 23.54));
    // await _expenseRepository.save(Expense(category: Category(cid: 4,title: "-"),description: "-",price: 33.15));
    // await _expenseRepository.save(Expense(category: Category(cid: 6,title: "-"),description: "-",price: 11.25));
    // print(await _expenseRepository.countAll());
    // (await _expenseRepository.findAllByCategoryId(2)).forEach((element) {
    //   print(element.toString());
    // });

    // print((await _expenseRepository.findById(6)).toString());
    // await _expenseRepository.close();


    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
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
