import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

import 'scanConfirm.dart';

class ServiceProviderPage extends StatefulWidget {
  @override
  _ServiceProviderPageState createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  String dropdownValue;
  List<String> orders = ["1", "2", "3", "4"];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyLoading.dismiss();
    });
    dismissAllToast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = width / 961.5;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text("Service Provider"),
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
        ),
        preferredSize: Size.fromHeight(height * 0.1),
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
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.6,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please Select the Order Number",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 40 * screenRadio),
                        ),
                        DropdownButton<String>(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          iconSize: 50 * screenRadio,
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          underline: Container(),
                          items: orders
                              .map<DropdownMenuItem<String>>((String order) {
                            return DropdownMenuItem<String>(
                              value: order,
                              child: Container(
                                width: width * 0.4,
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
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Container(
                      width: width * 0.4,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        "Scan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 40 * screenRadio),
                      ),
                    ),
                    onPressed: (dropdownValue != null)
                        ? () {
                            EasyLoading.show(status: 'loading...');
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new ScanConfirmPage(
                                  orderNo: dropdownValue,
                                ),
                              ),
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
