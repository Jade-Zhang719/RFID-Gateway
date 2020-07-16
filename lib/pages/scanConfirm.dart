import 'dart:async';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hand_signature/signature.dart';
import 'package:signalr_client/hub_connection.dart';

import '../clothIcon.dart';
import '../hub/rfidHub.dart';
import '../language/languageSetting.dart';
import '../language/translation/localization.dart';

class ScanConfirmPage extends StatefulWidget {
  final String orderNo;

  const ScanConfirmPage({Key key, this.orderNo}) : super(key: key);
  @override
  _ScanConfirmPageState createState() => _ScanConfirmPageState();
}

class _ScanConfirmPageState extends State<ScanConfirmPage> {
  String orderNo;
  int itemType;

  dynamic scannedProduct;
  List scannedEpcs;

  RFIDHub _rfidHub = RFIDHub();

  // ignore: cancel_subscriptions
  StreamSubscription<Object> _subscription;

  HandSignatureControl control = new HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  // ValueNotifier<ByteData> rawImage = ValueNotifier<ByteData>(null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyLoading.dismiss();
    });
    print("************ Scan Confirm Page ************");
    orderNo = widget.orderNo;
    itemType = 2;
    scannedEpcs = [];

    super.initState();
  }

  @override
  void didUpdateWidget(ScanConfirmPage oldWidget) {
    orderNo = widget.orderNo;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    this._subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = [width / 960, height / 552].reduce(min);

    BoxDecoration buttonBox = BoxDecoration(
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
    );

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

    Container _itemBuilder1(String variety, int count, Color color) {
      IconData cloth = (variety == "T-shirt")
          ? ClothIcons.Tshirt
          : (variety == "Trousers")
              ? ClothIcons.Trousers
              : (variety == "Jacket")
                  ? ClothIcons.Jacket
                  : ClothIcons.Accessories;
      return Container(
        width: width * 0.2,
        height: height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.2,
              height: height * 0.15,
              padding: EdgeInsets.all(height * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0)
                ],
                color: color,
              ),
              child: Icon(
                cloth,
                color: Colors.white,
                size: 50 * screenRadio,
              ),
            ),
            Container(
              width: width * 0.2,
              height: height * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0)
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.15,
                    height: width * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: 60 * screenRadio),
                    ),
                  ),
                  Text(
                    '${Translations.of(context).text(variety)}',
                    style: TextStyle(color: color, fontSize: 30 * screenRadio),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Container _itemBuilder2(String variety, int count, Color color) {
      IconData cloth = (variety == "T-shirt")
          ? ClothIcons.Tshirt
          : (variety == "Trousers")
              ? ClothIcons.Trousers
              : (variety == "Jacket")
                  ? ClothIcons.Jacket
                  : ClothIcons.Accessories;
      return Container(
          width: width * 0.2,
          height: height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0)
            ],
            color: Colors.white,
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: width * 0.15,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Icon(
                    cloth,
                    color: Colors.white,
                    size: 80 * screenRadio,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  count.toString(),
                  style: TextStyle(color: color, fontSize: 60 * screenRadio),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: color,
                  ),
                  child: Text(
                    '${Translations.of(context).text(variety)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * screenRadio,
                    ),
                  ),
                ),
              ),
            ],
          ));
    }

    Container _itemBuilder3(String variety, int count, Color color) {
      IconData cloth = (variety == "T-shirt")
          ? ClothIcons.Tshirt
          : (variety == "Trousers")
              ? ClothIcons.Trousers
              : (variety == "Jacket")
                  ? ClothIcons.Jacket
                  : ClothIcons.Accessories;
      return Container(
        width: width * 0.44,
        height: height * 0.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0)
          ],
          color: color,
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: width * 0.05),
                child: Icon(
                  cloth,
                  color: Colors.white,
                  size: 120 * screenRadio,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count.toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 90 * screenRadio),
                  ),
                  Text(
                    '${Translations.of(context).text(variety)}',
                    style: TextStyle(
                        color: Colors.white, fontSize: 40 * screenRadio),
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
            '${Translations.of(context).text("Cloth Scan -- Order No:")}' +
                "$orderNo"),
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
            Navigator.pop(context);
          },
        ),
        actions: [
          _uiSettings(),
          LanguageSetting(),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (itemType == 1)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _itemBuilder1("T-shirt", 1, Color(0XFFA49F94)),
                        _itemBuilder1(
                            "Trousers", 2, Theme.of(context).accentColor),
                        _itemBuilder1("Jacket", 3, Color(0XFFA49F94)),
                        _itemBuilder1(
                            "Accessories", 4, Theme.of(context).accentColor),
                      ],
                    )
                  : (itemType == 2)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _itemBuilder2("T-shirt", 1, Color(0XFFA49F94)),
                            _itemBuilder2(
                                "Trousers", 2, Theme.of(context).accentColor),
                            _itemBuilder2("Jacket", 3, Color(0XFFA49F94)),
                            _itemBuilder2("Accessories", 4,
                                Theme.of(context).accentColor),
                          ],
                        )
                      : Wrap(
                          spacing: width * 0.04,
                          runSpacing: height * 0.05,
                          children: [
                            _itemBuilder3("T-shirt", 1, Color(0XFFA49F94)),
                            _itemBuilder3(
                                "Trousers", 2, Theme.of(context).accentColor),
                            _itemBuilder3(
                                "Jacket", 3, Theme.of(context).accentColor),
                            _itemBuilder3("Accessories", 4, Color(0XFFA49F94)),
                          ],
                        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.2,
                    height: height * 0.1,
                    child: Text(
                      '${Translations.of(context).text("Total:")}${scannedEpcs.length.toString()}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30 * screenRadio),
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      alignment: Alignment.center,
                      decoration: (this._rfidHub.getConnectionState() ==
                              HubConnectionState.Disconnected)
                          ? buttonBox
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                      child: Text(
                        '${Translations.of(context).text("Scan")}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 30 * screenRadio),
                      ),
                    ),
                    onPressed: (this._rfidHub.getConnectionState() ==
                            HubConnectionState.Connected)
                        ? null
                        : () async {
                            await this._rfidHub.connect().then((value) {
                              if (this._rfidHub.getConnectionState() ==
                                  HubConnectionState.Connected) {
                                print(this._rfidHub.getConnectionState());

                                this
                                    ._rfidHub
                                    .trayListener((List<Object> results) {
                                  print("Tray: $results");
                                  this._subscription = this
                                      ._rfidHub
                                      .streamProducts()
                                      .listen((epc) async {
                                    if (epc is Map) {
                                      String epcString = epc['epc']
                                          .toString()
                                          .replaceAll(" ", "");

                                      bool alreadyAdd = false;

                                      for (String e in this.scannedEpcs) {
                                        if (e == epcString) {
                                          alreadyAdd = true;
                                          break;
                                        }
                                      }
                                      setState(() {
                                        if (!alreadyAdd && epc["active"] == 1) {
                                          this.scannedEpcs.add(epcString);
                                          alreadyAdd = true;
                                          print(epc);
                                          print(
                                              "Scanned Epcs: ${this.scannedEpcs}");
                                        }
                                      });

                                      // if (!alreadyAdd && epc['active'] == 1) {
                                      //   await this.addEpcProductReceived(epcString);
                                      //   print("Already Added: ${this.scannedEpcs}");
                                      // }

                                      // if (alreadyAdd && epc['active'] == 1) {
                                      //   this.removeEpcProductsInTray(epcString);
                                      // }
                                    }
                                  });
                                });
                                this._rfidHub.associateMobileDevice();
                              }
                            });
                          },
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      alignment: Alignment.center,
                      decoration: (this._rfidHub.getConnectionState() ==
                              HubConnectionState.Connected)
                          ? buttonBox
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                      child: Text(
                        '${Translations.of(context).text("Reset")}',
                        style: TextStyle(
                            color: Colors.white, fontSize: 30 * screenRadio),
                      ),
                    ),
                    onPressed: (this._rfidHub.getConnectionState() ==
                            HubConnectionState.Connected)
                        ? () async {
                            await _rfidHub.disconnect();
                            print(this._rfidHub.getConnectionState());
                            setState(() {
                              scannedEpcs.clear();
                            });
                          }
                        : null,
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.1,
                      alignment: Alignment.center,
                      decoration: buttonBox,
                      child: Text(
                        '${Translations.of(context).text("Signature")}',
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
                                                    type:
                                                        SignatureDrawType.shape,
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
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: buttonBox,
                                              width: width * 0.15,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${Translations.of(context).text("Clear")}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15 * screenRadio),
                                              ),
                                            ),
                                            onPressed: control.clear,
                                          ),
                                          FlatButton(
                                              padding: EdgeInsets.all(0),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: buttonBox,
                                                width: width * 0.15,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${Translations.of(context).text("Confirm")}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          15 * screenRadio),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await showGeneralDialog(
                                                    context: context,
                                                    // ignore: missing_return
                                                    pageBuilder: (context,
                                                        anim1, anim2) {},
                                                    barrierColor: Colors.grey
                                                        .withOpacity(.4),
                                                    barrierDismissible: false,
                                                    barrierLabel: "",
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 400),
                                                    transitionBuilder: (context,
                                                        anim1, anim2, child) {
                                                      return Transform.scale(
                                                        scale: anim1.value,
                                                        child: Opacity(
                                                          opacity: anim1.value,
                                                          child: AlertDialog(
                                                            title: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Color(
                                                                      0XFFaec49d),
                                                                  size: 90 *
                                                                      screenRadio,
                                                                ),
                                                                Text(
                                                                  '${Translations.of(context).text("Successful")}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 30 *
                                                                        screenRadio,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            contentPadding: EdgeInsets.fromLTRB(
                                                                24 *
                                                                    screenRadio,
                                                                15 *
                                                                    screenRadio,
                                                                24 *
                                                                    screenRadio,
                                                                15 *
                                                                    screenRadio),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    '${Translations.of(context).text("The order is signed successful.")}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 170 *
                                                                      screenRadio,
                                                                  margin: EdgeInsets.only(
                                                                      top: 20 *
                                                                          screenRadio,
                                                                      bottom: 10 *
                                                                          screenRadio),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0XFFaec49d),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(30)),
                                                                  ),
                                                                  child:
                                                                      FlatButton(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    child: Text(
                                                                      '${Translations.of(context).text("OK")}',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });

                                                // EasyLoading.show(
                                                //     status: 'loading...');
                                                // rawImage.value =
                                                //     await control.toImage(
                                                //   color: Colors.black,
                                                // );
                                                control.clear();
                                                Navigator.of(context).pop();
                                              }),
                                          FlatButton(
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: buttonBox,
                                              width: width * 0.15,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${Translations.of(context).text("Cancel")}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15 * screenRadio),
                                              ),
                                            ),
                                            onPressed: () {
                                              control.clear();
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
      ),
    );
  }
}
