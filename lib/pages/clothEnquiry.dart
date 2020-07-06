import 'package:flutter/material.dart';

class ClothEnquiryPage extends StatefulWidget {
  @override
  _ClothEnquiryPageState createState() => _ClothEnquiryPageState();
}

class _ClothEnquiryPageState extends State<ClothEnquiryPage> {
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
                margin: EdgeInsets.only(top: height * 0.1),
                child: Table(
                  border: TableBorder.all(color: Colors.white),
                  children: [
                    TableRow(children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        color: Colors.pink[200],
                        child: Text(
                          "Variety",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        color: Colors.lightBlue,
                        child: Text(
                          "Qty",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        color: Colors.pink[200],
                        child: Text(
                          "Statues",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text(
                          "T-shirt",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text(
                          "2",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Text(
                          "Washing",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20 * screenRadio),
                        ),
                      ),
                    ]),
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
