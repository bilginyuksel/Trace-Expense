import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trace_expanses/model/category.dart';

class CategoryDialogBuilder extends StatelessWidget {

  String categoryToSave;
  Function saveCategory;

  CategoryDialogBuilder({this.saveCategory});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 230,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left:15, right:15,top:15, bottom: 5),
              child: Text(
                'Save Category',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromRGBO(49, 87, 110, 1)),
              ),
            ),
            Padding(child: Divider(height: 1, color: Colors.black,), padding: EdgeInsets.symmetric(horizontal: 30),),
            Padding(
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10, top: 30),
              child: TextField(
                onChanged: (String t) => categoryToSave = t,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(16),
              child: Text('Save', style: TextStyle(fontSize: 18,)),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () async {
                await saveCategory(Category(title: categoryToSave));
                Navigator.pop(context);
              }
            )
          ],
        ),
      )
    ) ;
  }
}