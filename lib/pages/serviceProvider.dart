import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = width / 961.5;
    return Scaffold(
      body: Stack(
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
                    color: Theme.of(context).primaryColor,
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
                                color: Theme.of(context).primaryColor,
                                fontSize: 40 * screenRadio),
                          ),
                          DropdownButton<String>(
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            value: dropdownValue,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            underline: Container(),
                            elevation: 16,
                            items: orders
                                .map<DropdownMenuItem<String>>((String order) {
                              return DropdownMenuItem<String>(
                                value: order,
                                child: Container(
                                  width: width * 0.1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    order,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Scan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 40 * screenRadio),
                        ),
                      ),
                      onPressed: () {
                        EasyLoading.show(status: 'loading...');
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
            margin:
                EdgeInsets.only(left: 20 * screenRadio, top: 20 * screenRadio),
            alignment: Alignment.topLeft,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
