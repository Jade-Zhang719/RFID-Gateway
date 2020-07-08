import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rfidgateway/pages/clothEnquiry.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
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
                    radius: Radius.circular(10),
                    child: Container(
                      width: width * 0.9,
                      height: height * 0.6,
                      alignment: Alignment.center,
                      child: Text(
                        "Please Scan Your Staff Card",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 50 * screenRadio),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 40 * screenRadio),
                        ),
                      ),
                      onPressed: () {
                        EasyLoading.show(status: 'loading...');
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new ClothEnquiryPage(),
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
                  size: 40 * screenRadio,
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
