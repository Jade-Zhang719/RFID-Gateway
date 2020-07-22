import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../calendar/dayPickerForEnquiry.dart' as dpe;
import '../calendar/event.dart';
import '../clothIcon.dart';
import '../language/languageSetting.dart';
import '../language/translation/localization.dart';

class ClothEnquiryPage extends StatefulWidget {
  @override
  _ClothEnquiryPageState createState() => _ClothEnquiryPageState();
}

class _ClothEnquiryPageState extends State<ClothEnquiryPage> {
  DateTime selectedDate;
  String date;
  Event event;

  bool isEventDate;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyLoading.dismiss();
    });

    isEventDate = false;
    print("************ Cloth Enquiry Page ************");
    super.initState();
  }

  @override
  void didUpdateWidget(ClothEnquiryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double screenRadio = [width / 960, height / 552].reduce(min);

    Container _staffClothCardBuilder(
        String variety, int loan, int wash, int use) {
      IconData cloth = (variety == "T-shirt")
          ? ClothIcons.Tshirt
          : (variety == "Trousers")
              ? ClothIcons.Trousers
              : (variety == "Jacket")
                  ? ClothIcons.Jacket
                  : ClothIcons.Accessories;
      return Container(
        width: width * 0.3,
        height: height * 0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width * 0.08,
              alignment: Alignment.center,
              child: Icon(
                cloth,
                color: Theme.of(context).primaryColor,
                size: 60 * screenRadio,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${Translations.of(context).text("Loan")}' +
                        ": ${loan.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20 * screenRadio),
                  ),
                  Text(
                    '${Translations.of(context).text("Laundry")}' +
                        ": ${wash.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20 * screenRadio),
                  ),
                  Text(
                    '${Translations.of(context).text("In use")}' +
                        ": ${use.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20 * screenRadio),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Container _eventBoardBuilder() {
      // String time = formatDate(event.date, [HH, ':', nn]);
      Color bgColor;
      Color txColor;
      if ((event.date.day == DateTime.now().day) &&
          (event.date.month == DateTime.now().month) &&
          (event.date.year == DateTime.now().year)) {
        bgColor = Colors.purple[50];
        txColor = Colors.purple[200];
      } else if (event.date.weekday == 7) {
        bgColor = Colors.red[50];
        txColor = Colors.red[300];
      } else {
        bgColor = Colors.cyan[50];
        txColor = Colors.cyan[300];
      }
      return Container(
        width: width * 0.2,
        height: height * 0.28,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10 * screenRadio),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Laundry",
                  style: TextStyle(color: txColor, fontSize: 30 * screenRadio),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10 * screenRadio),
                      child: Icon(
                        Icons.attachment,
                        color: txColor,
                        size: 30 * screenRadio,
                      ),
                    ),
                    Container(
                      width: width * 0.14,
                      child: Text(
                        event.dis,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: txColor, fontSize: 15 * screenRadio),
                      ),
                    ),
                  ],
                ),
                Text(
                  event.qty.toString(),
                  style: TextStyle(color: txColor, fontSize: 40 * screenRadio),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${Translations.of(context).text("Cloth Enquiry")}'),
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
            height: height * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.65,
                      height: height * 0.5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: height * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: width * 0.01,
                          color: Theme.of(context).cardColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: dpe.CustomDayPicker(
                        events: events,
                        width: width * 0.5,
                        height: height * 0.5,
                        onDateChange: (v) {
                          setState(() {
                            this.selectedDate = v;

                            this.date = formatDate(v, [yyyy, "-", mm, "-", dd]);
                            events.forEach((element) {
                              DateTime d = element.date;
                              if (v.year == d.year &&
                                  v.month == d.month &&
                                  v.day == d.day) {
                                event = element;
                              }
                            });
                            isEventDate = eventsDates?.any((DateTime d) =>
                                v.year == d.year &&
                                v.month == d.month &&
                                v.day == d.day);
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width * 0.65,
                      height: height * 0.28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.42,
                            height: height * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.7,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding:
                                        EdgeInsets.only(right: width * 0.02),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 150 * screenRadio,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${Translations.of(context).text("Name:")}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 30 * screenRadio),
                                      ),
                                      Text(
                                        "XXXXX",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20 * screenRadio),
                                      ),
                                      Text(
                                        '${Translations.of(context).text("Staff ID:")}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 30 * screenRadio),
                                      ),
                                      Text(
                                        "XXXXXXXXXXX",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20 * screenRadio),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isEventDate
                              ? _eventBoardBuilder()
                              : Container(
                                  width: width * 0.2,
                                  height: height * 0.28,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Text(
                                    '${Translations.of(context).text("No Record")}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30 * screenRadio,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    // isEventDate
                    //     ? _eventBoardBuilder()
                    //     : Container(
                    //         width: width * 0.65,
                    //         height: height * 0.28,
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               width: width * 0.3,
                    //               height: height * 0.28,
                    //             ),
                    //             Container(
                    //               width: width * 0.3,
                    //               height: height * 0.28,
                    //               alignment: Alignment.center,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: Theme.of(context).accentColor,
                    //               ),
                    //               child: Text(
                    //                 '${Translations.of(context).text("No Record")}',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 30 * screenRadio,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                  ],
                ),
                Container(
                  width: width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _staffClothCardBuilder("T-shirt", 40, 20, 80),
                      _staffClothCardBuilder("Trousers", 40, 20, 80),
                      _staffClothCardBuilder("Jacket", 40, 20, 80),
                      _staffClothCardBuilder("Accessories", 40, 20, 80),
                    ],
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

final List<Event> events = [
  Event(DateTime.now().subtract(Duration(days: 3)), "Order TXO19-00009 begin",
      15),
  Event(DateTime.now().subtract(Duration(days: 13)), "Order TXO19-00010 begin",
      26),
  Event(DateTime.now().subtract(Duration(days: 30)), "Order TXO19-00011 begin",
      33),
  Event(DateTime.now(), "Order TXO19-00009 end", 4),
  Event(DateTime.now().add(Duration(days: 3)), "Order TXO19-00012 begin", 58),
  Event(DateTime.now().add(Duration(days: 13)), "Order TXO19-00010 begin", 62),
  Event(DateTime.now().add(Duration(days: 30)), "Order TXO19-00011 begin", 74),
];

List<DateTime> eventsDates =
    events?.map<DateTime>((Event e) => e.date)?.toList();
