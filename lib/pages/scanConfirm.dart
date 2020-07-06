import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';

class ScanConfirmPage extends StatefulWidget {
  @override
  _ScanConfirmPageState createState() => _ScanConfirmPageState();
}

class _ScanConfirmPageState extends State<ScanConfirmPage> {
  HandSignatureControl control = new HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  ValueNotifier<ByteData> rawImage = ValueNotifier<ByteData>(null);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Container _itemBuilder(IconData icon, String variety, int count) {
      return Container(
        width: width * 0.2,
        height: height * 0.7,
        margin: EdgeInsets.only(top: height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.2,
              height: height * 0.4,
              color: Colors.pink[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    variety,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.2,
              height: height * 0.2,
              color: Colors.lightBlue,
              child: Text(
                count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _itemBuilder(Icons.shopping_basket, "T-shirt", 1),
                    _itemBuilder(Icons.shopping_basket, "Trousers", 2),
                    _itemBuilder(Icons.shopping_basket, "Jacket", 3),
                    _itemBuilder(Icons.shopping_basket, "Accessories", 4),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.1,
                        margin: EdgeInsets.only(right: width * 0.02),
                        alignment: Alignment.center,
                        color: Colors.pink[200],
                        child: Text(
                          "Signature",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: AspectRatio(
                                            aspectRatio: 2.0,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  constraints:
                                                      BoxConstraints.expand(),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child:
                                                      HandSignaturePainterView(
                                                    control: control,
                                                    type:
                                                        SignatureDrawType.shape,
                                                  ),
                                                ),
                                                CustomPaint(
                                                  painter:
                                                      DebugSignaturePainterCP(
                                                    control: control,
                                                    cp: false,
                                                    cpStart: false,
                                                    cpEnd: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FlatButton(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              color: Colors.blueAccent,
                                              width: width * 0.15,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Clear",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            onPressed: control.clear,
                                          ),
                                          FlatButton(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                color: Colors.pink[200],
                                                width: width * 0.15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              onPressed: () async {
                                                rawImage.value =
                                                    await control.toImage(
                                                  color: Colors.black,
                                                );
                                                Navigator.of(context).pop();
                                              }),
                                          FlatButton(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              color: Colors.blueAccent,
                                              width: width * 0.15,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                  ],
                ),
              ],
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
