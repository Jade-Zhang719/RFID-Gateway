import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rfidgateway/api.dart';

import '../language/languageSetting.dart';
import '../language/translation/localization.dart';
import 'scanConfirm.dart';

class ServiceProviderPage extends StatefulWidget {
  @override
  _ServiceProviderPageState createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  int itemType;
  String selectValue;
  List<String> orders = [];
  @override
  void initState() {
    createStockTransfer().then((value) {
      setState(() {
        value.stockTransfer.forEach((element) {
          orders.add(element.toString());
        });
        print(orders);
      });
    });
    itemType = 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyLoading.dismiss();
    });
    // dismissAllToast();
    print("************ Service Provider Page ************");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = [width / 960, height / 552].reduce(min);

    Container _uiSettings() {
      return Container(
        margin: EdgeInsets.only(right: 60 * screenRadio),
        child: Row(
          children: [
            Container(
              width: 50 * screenRadio,
              child: Text(
                "design",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15 * screenRadio,
                ),
              ),
            ),
            Container(
              width: 20 * screenRadio,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * screenRadio,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    itemType = 1;
                  });
                },
              ),
            ),
            Container(
              width: 20 * screenRadio,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * screenRadio,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    itemType = 2;
                  });
                },
              ),
            ),
            Container(
              width: 20 * screenRadio,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15 * screenRadio,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    itemType = 3;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }

    Container _design1() {
      return Container(
        width: width * 0.9,
        height: height * 0.6,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${Translations.of(context).text("Please Select the Order Number")}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40 * screenRadio),
            ),
            Container(
              width: width * 0.9,
              height: height * 0.4,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.0,
                  ),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        width: width * 0.25,
                        height: height * 0.15,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10 * screenRadio),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            )
                          ],
                          color: selectValue == orders[index]
                              ? Theme.of(context).cardColor
                              : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20 * screenRadio),
                            ),
                            Text(
                              orders[index],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20 * screenRadio),
                            ),
                            Text(
                              "${Translations.of(context).text("Total Order Qty:")}${Random().nextInt(10).toString()}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15 * screenRadio),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectValue = orders[index];
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      );
    }

    Container _design2() {
      return Container(
        width: width * 0.6,
        height: height * 0.4,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${Translations.of(context).text("Please Select the Order Number")}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40 * screenRadio),
            ),
            DropdownButton<String>(
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              iconEnabledColor: Theme.of(context).primaryColor,
              iconSize: 50 * screenRadio,
              value: selectValue,
              onChanged: (String newValue) {
                setState(() {
                  selectValue = newValue;
                  print("The selected order number is $selectValue.");
                });
              },
              underline: Container(),
              items: orders.map<DropdownMenuItem<String>>((String order) {
                return DropdownMenuItem<String>(
                  value: order,
                  child: Container(
                    width: width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      order,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25 * screenRadio),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Container _design3() {
      return Container(
        width: width * 0.9,
        height: height * 0.6,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * 0.9,
              height: height * 0.1,
              alignment: Alignment.center,
              child: Text(
                '${Translations.of(context).text("Please Select the Order Number")}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40 * screenRadio),
              ),
            ),
            Container(
              width: width * 0.9,
              height: height * 0.48,
              child: Column(
                children: [
                  Container(
                    width: width * 0.8,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(5 * screenRadio),
                            alignment: Alignment.center,
                            child: Text(
                              "SEQ#",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * screenRadio),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.all(5 * screenRadio),
                            alignment: Alignment.center,
                            child: Text(
                              "Order Number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * screenRadio),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(5 * screenRadio),
                            alignment: Alignment.center,
                            child: Text(
                              "Total Qty",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20 * screenRadio),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.38,
                    child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: width * 0.8,
                            height: height * 0.12,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10 * screenRadio),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                )
                              ],
                              color: selectValue == orders[index]
                                  ? Theme.of(context).cardColor
                                  : Colors.white,
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(5 * screenRadio),
                                    alignment: Alignment.center,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15 * screenRadio),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(5 * screenRadio),
                                    alignment: Alignment.center,
                                    child: Text(
                                      orders[index],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15 * screenRadio),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(5 * screenRadio),
                                    alignment: Alignment.center,
                                    child: Text(
                                      Random().nextInt(10).toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 10 * screenRadio),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(5 * screenRadio),
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      icon: Icon(
                                        selectValue == orders[index]
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: Theme.of(context).primaryColor,
                                        size: 25 * screenRadio,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectValue = orders[index];
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Translations.of(context).text("Service Provider")}',
        ),
        leading: FlatButton(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        actions: [
          _uiSettings(),
          LanguageSetting(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: width * 0.9,
            height: height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DottedBorder(
                  color: Theme.of(context).primaryColor,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  child: itemType == 1
                      ? _design1()
                      : itemType == 2 ? _design2() : _design3(),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.1,
                    decoration: (selectValue != null)
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlue[300],
                                Colors.blueAccent,
                                Colors.blue[300],
                                // Color(0XFF817E7E),
                                // Color(0XFFBBB8B0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                    alignment: Alignment.center,
                    child: Text(
                      '${Translations.of(context).text("Next")}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 30 * screenRadio),
                    ),
                  ),
                  onPressed: (selectValue != null)
                      ? () {
                          EasyLoading.show(
                              status:
                                  '${Translations.of(context).text("Loading...")}');
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new ScanConfirmPage(
                                orderNo: selectValue,
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
