import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../language/languageSetting.dart';
import '../language/translation/localization.dart';
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
    // dismissAllToast();
    print("************ Service Provider Page ************");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = [width / 960, height / 552].reduce(min);

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
                  child: Container(
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
                        DropdownButton<String>(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          iconSize: 50 * screenRadio,
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              print(
                                  "The selected order number is $dropdownValue.");
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
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.1,
                    decoration: (dropdownValue != null)
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
                                Color(0XFF817E7E),
                                Color(0XFFBBB8B0),
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
                      '${Translations.of(context).text("Start")}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 40 * screenRadio),
                    ),
                  ),
                  onPressed: (dropdownValue != null)
                      ? () {
                          EasyLoading.show(
                              status:
                                  '${Translations.of(context).text("loading...")}');
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
