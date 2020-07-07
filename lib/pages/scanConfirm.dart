import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

    Container _itemBuilder(
        IconData icon, String variety, int count, Color color) {
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
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
                    style: TextStyle(
                        color: Colors.white, fontSize: 25 * screenRadio),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.2,
              height: height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(color: color, fontSize: 40 * screenRadio),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _itemBuilder(Icons.shopping_basket, "T-shirt", 1,
                        Theme.of(context).primaryColor),
                    _itemBuilder(Icons.shopping_basket, "Trousers", 2,
                        Theme.of(context).accentColor),
                    _itemBuilder(Icons.shopping_basket, "Jacket", 3,
                        Theme.of(context).primaryColor),
                    _itemBuilder(Icons.shopping_basket, "Accessories", 4,
                        Theme.of(context).accentColor),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Signature",
                          style: TextStyle(
                              color: Colors.white, fontSize: 30 * screenRadio),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: AspectRatio(
                                            aspectRatio: 2.0,
                                            child: Stack(
                                              children: [
                                                DottedBorder(
                                                  color: Colors.grey,
                                                  borderType: BorderType.RRect,
                                                  child: Container(
                                                    constraints:
                                                        BoxConstraints.expand(),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child:
                                                        HandSignaturePainterView(
                                                      control: control,
                                                      type: SignatureDrawType
                                                          .shape,
                                                    ),
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
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            FlatButton(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                width: width * 0.15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Clear",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          15 * screenRadio),
                                                ),
                                              ),
                                              onPressed: control.clear,
                                            ),
                                            FlatButton(
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  width: width * 0.15,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            15 * screenRadio),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  // EasyLoading.show(
                                                  //     status: 'loading...');
                                                  rawImage.value =
                                                      await control.toImage(
                                                    color: Colors.black,
                                                  );
                                                  Navigator.of(context).pop();
                                                }),
                                            FlatButton(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                width: width * 0.15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          15 * screenRadio),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
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
