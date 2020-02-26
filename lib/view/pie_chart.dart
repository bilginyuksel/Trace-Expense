import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:trace_expanses/model/category.dart';
import 'package:trace_expanses/model/expense.dart';

class DatumLegendWithMeasures extends StatelessWidget {

  List<charts.Series> seriesList;
  final bool animate;
  List<Category> categories = new List();
  List<Expense> expenses = new List();

  DatumLegendWithMeasures(List<Category> categories, List<Expense> expenses, {this.animate}){
    seriesList = _createData(categories, expenses);
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

  
  List<charts.Series<CategoryExpenseSeries, String>> _createData(List<Category> categories, List<Expense> expenses){

    List<CategoryExpenseSeries> expenseList = new List();
    Map<int, double> mapToCalculate= new Map();

    categories.forEach((element) {
      mapToCalculate[element.cid] = 0;
    });    

  
    expenses.forEach((element) {
      mapToCalculate.update(element.category.cid, (value) => value+ element.price);
    });

    mapToCalculate.forEach((key, value) {
      expenseList.add(CategoryExpenseSeries(price: value, category: categories[key-1].title));
    });

    return [
      new charts.Series<CategoryExpenseSeries, String>(
        id:'Expenses',
        domainFn: (CategoryExpenseSeries expense, _) => expense.category,
        measureFn: (CategoryExpenseSeries expense, _) => expense.price,
        data : expenseList,
        labelAccessorFn: (CategoryExpenseSeries row, _) => '${row.price}: ${row.category}',

      )
    ];

  }

}

class CategoryExpenseSeries {
  final String category;
  final double price;

  CategoryExpenseSeries({this.category, this.price});
}


class DateTimeComboLinePointChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;
  List<Expense> expenses = new List();  

  DateTimeComboLinePointChart(List<Expense> expenses, {this.animate}){
    this.seriesList = _createData(expenses);
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        new charts.PointRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<TimeSeriesExpense, DateTime>> _createData(List<Expense> expenses) {

    List<TimeSeriesExpense> timeSeriesExpenseList = new List();

    expenses.forEach((element) {
      timeSeriesExpenseList.add(TimeSeriesExpense(element.date, element.price));
    });

    return [
      
      new charts.Series<TimeSeriesExpense, DateTime>(
        id: 'LineExpense',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesExpense expense, _) => expense.time,
        measureFn: (TimeSeriesExpense expense, _) => expense.expense,
        data: timeSeriesExpenseList,
      ),
      new charts.Series<TimeSeriesExpense, DateTime>(
          id: 'ScatterExpense',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesExpense expense, _) => expense.time,
          measureFn: (TimeSeriesExpense expense, _) => expense.expense,
          data: timeSeriesExpenseList)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesExpense {
  final DateTime time;
  final double expense;

  TimeSeriesExpense(this.time, this.expense);
}