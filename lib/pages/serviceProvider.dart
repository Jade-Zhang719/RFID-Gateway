import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'scanConfirm.dart';

class ServiceProviderPage extends StatefulWidget {
  @override
  _ServiceProviderPageState createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  String dropdownValue;
  List<String> orders = ["1", "2", "3", "4"];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = width / 961.5;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Colors.blueGrey[900],
            Colors.blueGrey[700],
            Colors.blueGrey,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: width * 0.9,
                height: height * 0.8,
                margin: EdgeInsets.only(top: height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DottedBorder(
                      color: Colors.white,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12),
                      child: Container(
                        width: width * 0.9,
                        height: height * 0.6,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Please Select the Order Number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40 * screenRadio),
                            ),
                            DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              dropdownColor: Colors.blueGrey[700],
                              value: dropdownValue,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              underline: Container(),
                              elevation: 16,
                              items: orders.map<DropdownMenuItem<String>>(
                                  (String order) {
                                return DropdownMenuItem<String>(
                                  value: order,
                                  child: Container(
                                    width: width * 0.1,
                                    alignment: Alignment.center,
                                    child: Text(
                                      order,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20 * screenRadio),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue,
                          ),
                          child: Text(
                            "Scan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40 * screenRadio),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new ScanConfirmPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 40 * screenRadio,
              width: 40 * screenRadio,
              margin: EdgeInsets.only(
                  left: 20 * screenRadio, top: 20 * screenRadio),
              alignment: Alignment.topLeft,
              child: FlatButton(
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
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
