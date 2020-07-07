import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

//stock pie charts
class Stock {
  final String loan;
  final int qty;
  Color pieColor;
  Stock(this.loan, this.qty, this.pieColor);
}

List<Stock> tShirtStock = [
  Stock("Loaned", 150, ColorUtil.fromDartColor(Colors.lightBlue[100])),
  Stock("Remained", 50, ColorUtil.fromDartColor(Colors.lightBlue)),
];
List<Stock> trousersStock = [
  Stock("Loaned", 120, ColorUtil.fromDartColor(Colors.lightBlue[100])),
  Stock("Remained", 80, ColorUtil.fromDartColor(Colors.lightBlue)),
];
List<Stock> jacketStock = [
  Stock("Loaned", 70, ColorUtil.fromDartColor(Colors.lightBlue[100])),
  Stock("Remained", 130, ColorUtil.fromDartColor(Colors.lightBlue)),
];
List<Stock> accessoriesStock = [
  Stock("Loaned", 180, ColorUtil.fromDartColor(Colors.lightBlue[100])),
  Stock("Remained", 220, ColorUtil.fromDartColor(Colors.lightBlue)),
];
List<Stock> totalStock = [
  Stock("Loaned", 520, ColorUtil.fromDartColor(Colors.pink[50])),
  Stock("Remained", 480, ColorUtil.fromDartColor(Colors.pink[200])),
];

PieChart drawPieChart(String id, List<Stock> stockList) {
  List<Series<Stock, String>> seriesList = [
    Series(
      id: id,
      data: stockList,
      domainFn: (Stock totalStock, _) => totalStock.loan,
      measureFn: (Stock totalStock, _) => totalStock.qty,
      colorFn: (Stock totalStock, _) => totalStock.pieColor,
      labelAccessorFn: (Stock row, _) => '${row.loan}: ${row.qty.toString()}',
    )
  ];
  return PieChart(
    seriesList,
    animate: true,
    defaultRenderer: new ArcRendererConfig(
      arcWidth: 30,
      arcRendererDecorators: [
        new ArcLabelDecorator(
          labelPosition: ArcLabelPosition.auto,
        ),
      ],
    ),
  );
}
