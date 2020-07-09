import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

import 'clothEnquiry.dart';

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
      appBar: PreferredSize(
        child: AppBar(
          title: Text("Staff"),
          leading: FlatButton(
            padding: EdgeInsets.all(0),
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Icon(
                Icons.arrow_back,
                // size: 30 * screenRadio,
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
                    onPressed: () async {
                      await showGeneralDialog(
                          context: context,
                          pageBuilder: (context, anim1, anim2) {},
                          barrierColor: Colors.grey.withOpacity(.4),
                          barrierDismissible: false,
                          barrierLabel: "",
                          transitionDuration: Duration(milliseconds: 400),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Transform.scale(
                              scale: anim1.value,
                              child: Opacity(
                                opacity: anim1.value,
                                child: AlertDialog(
                                  title: Column(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Color(0XFFaec49d),
                                        size: 90 * screenRadio,
                                      ),
                                      Text(
                                        'Successful',
                                        style: TextStyle(
                                          fontSize: 30 * screenRadio,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      24 * screenRadio,
                                      15 * screenRadio,
                                      24 * screenRadio,
                                      15 * screenRadio),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Welcome!',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        width: 170 * screenRadio,
                                        margin: EdgeInsets.only(
                                            top: 20 * screenRadio,
                                            bottom: 10 * screenRadio),
                                        decoration: BoxDecoration(
                                          color: Color(0XFFaec49d),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              ),
                            );
                          });

                      EasyLoading.show(status: 'loading...');
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ClothEnquiryPage(),
                        ),
                      );
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     new MaterialPageRoute(
                      //       builder: (context) => new ClothEnquiryPage(),
                      //     ),
                      //     (route) => false);
                    },
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
