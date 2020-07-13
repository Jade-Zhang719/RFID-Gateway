import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hand_signature/signature.dart';

import '../language/translation/localization.dart';

class ScanConfirmPage extends StatefulWidget {
  final String orderNo;

  const ScanConfirmPage({Key key, this.orderNo}) : super(key: key);
  @override
  _ScanConfirmPageState createState() => _ScanConfirmPageState();
}

class _ScanConfirmPageState extends State<ScanConfirmPage> {
  String orderNo;

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
    orderNo = widget.orderNo;

    super.initState();
  }

  @override
  void didUpdateWidget(ScanConfirmPage oldWidget) {
    orderNo = widget.orderNo;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = width / 961.5;

    Container _itemBuilder(String variety, int count, Color color) {
      return Container(
        width: width * 0.2,
        height: height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.2,
              height: height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/cloth_icon/$variety.png',
                    width: 80 * screenRadio,
                  ),
                  Text(
                    '${Translations.of(context).text(variety)}',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25 * screenRadio),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.2,
              height: height * 0.15,
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
      appBar: PreferredSize(
        child: AppBar(
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
              // Navigator.popUntil(
              //   context,
              //   ModalRoute.withName('/service_provider'),
              // );
            },
          ),
        ),
        preferredSize: Size.fromHeight(height * 0.1),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _itemBuilder("T-shirt", 1, Theme.of(context).primaryColor),
                  _itemBuilder("Trousers", 2, Theme.of(context).accentColor),
                  _itemBuilder("Jacket", 3, Theme.of(context).primaryColor),
                  _itemBuilder("Accessories", 4, Theme.of(context).accentColor),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: width * 0.04),
                    child: Text(
                      '${Translations.of(context).text("Total:")}' + "10",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30 * screenRadio),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: width * 0.02),
                    child: FlatButton(
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
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
                                                  '${Translations.of(context).text("Clear")}',
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
                                                      pageBuilder: (context,
                                                          anim1, anim2) {},
                                                      barrierColor: Colors.grey
                                                          .withOpacity(.4),
                                                      barrierDismissible: false,
                                                      barrierLabel: "",
                                                      transitionDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  400),
                                                      transitionBuilder:
                                                          (context, anim1,
                                                              anim2, child) {
                                                        return Transform.scale(
                                                          scale: anim1.value,
                                                          child: Opacity(
                                                            opacity:
                                                                anim1.value,
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
                                                                          EdgeInsets.all(
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        '${Translations.of(context).text("OK")}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
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
                                                  '${Translations.of(context).text("Cancel")}',
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
