import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:rfidgateway/pages/clothEnquiry.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
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
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    child: Container(
                      width: width * 0.9,
                      height: height * 0.6,
                      alignment: Alignment.center,
                      child: Text(
                        "Please Scan Your Staff Card",
                        style: TextStyle(color: Colors.white, fontSize: 50),
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
                          color: Colors.lightBlue,
                        ),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
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
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: 20, top: 20),
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
    );
  }
}
