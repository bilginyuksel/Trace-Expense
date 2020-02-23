import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DatumLegendWithMeasures extends StatelessWidget {

  List<charts.Series> seriesList;
  final bool animate;

  DatumLegendWithMeasures({ this.animate}){
    seriesList = _sampleData();
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      behaviors: [
        new charts.DatumLegend(
          position:charts.BehaviorPosition.end,
          horizontalFirst:false,
          cellPadding: new EdgeInsets.only(right:4,bottom:4),
          showMeasures: true,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          entryTextStyle: charts.TextStyleSpec(fontSize: 14, ),
          measureFormatter: (num value){
            return value == null?'-':'$value';
          }
        )
      ],
    );
  }

  static List<charts.Series<LinearSales, String>> _sampleData(){
    
    final data = [
      LinearSales(category: "Drinks",price: 150),
      LinearSales(category: "Education",price:220),
      LinearSales(category: "Food", price:100),
      LinearSales(category: "Transportation", price: 50),
      LinearSales(category: "Entertainment", price:110)
    ];

    return [
      new charts.Series<LinearSales, String>(
        id:'Expenses',
        domainFn: (LinearSales expense, _) => expense.category,
        measureFn: (LinearSales expense, _) => expense.price,
        data : data,
        labelAccessorFn: (LinearSales row, _) => '${row.price}: ${row.category}',

      )
    ];

  }

}

class LinearSales {
  final String category;
  final int price;

  LinearSales({this.category, this.price});
}