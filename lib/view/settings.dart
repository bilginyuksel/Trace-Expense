import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trace_expanses/main.dart';
import 'package:trace_expanses/repository/categoryRepository.dart';
import 'package:trace_expanses/repository/db_bind.dart';
import 'package:trace_expanses/repository/systemRepository.dart';
import 'package:trace_expanses/service/categoryService.dart';
import 'package:trace_expanses/service/categoryServiceImpl.dart';
import 'package:trace_expanses/view/category_dialog.dart';

class Settings extends StatefulWidget{

  _Settings createState() => new _Settings();
}

class _Settings extends State<Settings> {

  SystemRepository _repository;
  ICategoryService _categoryService;
  CategoryRepository _categoryRepository;


  Widget _settingsCard(String content, Function onTap, dynamic icon){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.only(left:10, right:10, top:10),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 10,),
              Text(content, style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }


  void _changeWeekStartDate(){
    DateTime dateTime = null;
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      
      return CupertinoDatePicker(
        maximumDate: DateTime.now().add(Duration(days: 30)), 
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        minimumDate: DateTime.now().subtract(Duration(days: 30)),
        onDateTimeChanged: (DateTime t) async{
          dateTime = t;
          print("Changed Date Time : $dateTime");
        });
    }).whenComplete(() async {
        _repository = new SystemRepository(await SqfliteConnector.instance.db);
        if(dateTime!=null) await _repository.updateByCodeAndTitle("DATE", "WEEK", dateTime.toString());
    });
  }

  void _changeMonthStartDate(){
    DateTime dateTime = null;
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      
      return CupertinoDatePicker(
        maximumDate: DateTime.now().add(Duration(days: 30)), 
        initialDateTime: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        minimumDate: DateTime.now().subtract(Duration(days: 30)),
        onDateTimeChanged: (DateTime t) async{
          dateTime = t;
          print("Changed Date Time : $dateTime");
         
        });
    }).whenComplete(() async {
      _repository = new SystemRepository(await SqfliteConnector.instance.db);
      if(dateTime != null) await _repository.updateByCodeAndTitle("DATE", "MONTH", dateTime.toString());
    });
  }

  void _addCategory() async{
    _categoryRepository = new CategoryRepository(await SqfliteConnector.instance.db);
    _categoryService = new CategoryServiceImpl(_categoryRepository);


    CategoryDialogBuilder builder = new CategoryDialogBuilder(saveCategory: _categoryService.saveCategory,);
    showDialog(context: context, builder: (BuildContext context) {return builder;});
  }


  void _showInfo() {


  }

  void _income() {
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20,),
        _settingsCard("Week start date", ()=>_changeWeekStartDate(), Icons.date_range),
        _settingsCard("Month start date", ()=>_changeMonthStartDate(), Icons.date_range),
        _settingsCard("Add category", ()=>_addCategory(), Icons.category),
        _settingsCard("About", ()=>_showInfo(), Icons.info),
        _settingsCard("Income (Future Content)", ()=>_income(), Icons.settings_input_component),
      ],
    );
  }

}