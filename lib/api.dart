import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

//get the list of order codes.
Future<StockTransfer> createStockTransfer() async {
  final http.Response response = await http.post(
    "http://p2posrestapi.t2ms.com/api/Print/TxNumbers",
    headers: {
      "Content-Type": "application/json",
      "MobileDeviceId": "C583C5FF-93F8-4CD1-8FFD-FC47C4EC7C9A"
    },
    body: json.encode({
      "TxDateF": "2019-07-15",
      "TxDateT": "2019-09-2",
    }),
  );

  if (response.statusCode == 200) {
    return StockTransfer.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create StockTransfer.');
  }
}

class StockTransfer {
  final List<dynamic> stockTransfer;

  StockTransfer({this.stockTransfer});

  factory StockTransfer.fromJson(Map<String, dynamic> json) {
    return StockTransfer(
      stockTransfer: json["StockTransfer"],
    );
  }
}

//get the list of clothes by order codes.
Future<List<Order>> createOrder(String txNumbers) async {
  final http.Response response = await http.post(
    "http://p2posrestapi.t2ms.com/api/Print/StockTransfer",
    headers: {
      "Content-Type": "application/json",
      "MobileDeviceId": "C583C5FF-93F8-4CD1-8FFD-FC47C4EC7C9A"
    },
    body: json.encode({
      "TxNumbers": [txNumbers],
    }),
  );

  if (response.statusCode == 200) {
    List result = json.decode(response.body);
    List<Order> resultList = [];
    for (var i in result) {
      resultList.add(Order.fromJson(i));
    }
    return resultList;
  } else {
    throw Exception('Failed to create Order.');
  }
}

class Order {
  final String locationId;
  final String productId;
  final String barcode;
  final double qty;

  Order({
    this.locationId,
    this.productId,
    this.barcode,
    this.qty,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      locationId: json["LocationId"],
      productId: json["ProductId"],
      barcode: json["Barcode"],
      qty: json["Qty"],
    );
  }
}

//get product id by epc
Future<Product> createProduct(String epc) async {
  final http.Response response = await http.post(
    "http://boxland.p2posapi.retail-sys.com/InventoryAPI.asmx/GetRFIDInfo",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "MobileDeviceId": "C583C5FF-93F8-4CD1-8FFD-FC47C4EC7C9A",
      "Epc": epc,
    },
  );

  if (response.statusCode == 200) {
    return Product.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create Product.');
  }
}

class Product {
  final String epc;
  final String productId;
  final String description;
  final String barcode;

  Product({
    this.epc,
    this.productId,
    this.description,
    this.barcode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      epc: json["Epc"],
      productId: json["ProductId"],
      description: json["Description"],
      barcode: json["Barcode"],
    );
  }
}
