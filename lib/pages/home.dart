import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rfidgateway/clothIcon.dart';
import 'package:video_player/video_player.dart';

import '../calendar/dayPickerForHome.dart' as dph;
import '../calendar/event.dart';
import '../clothIcon.dart';
import '../language/languageSetting.dart';
import '../language/translation/localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie playerVideo;
  DateTime selectedDate;
  String date;

  @override
  void initState() {
    print("************ Home Page ************");
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/rfid_homepage.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16.0 / 9.0,
      autoPlay: true,
      looping: true,
      showControls: false,
    );
    playerVideo = Chewie(
      controller: _chewieController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
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

    Container _stockCardBuilder(
        IconData variety, int wash, int loan, int stock) {
      double loanPercent = loan / (loan + wash + stock) * 100;
      double washPercent = wash / (loan + wash + stock) * 100;
      double stockPercent = stock / (loan + wash + stock) * 100;
      return Container(
        width: width * 0.45,
        height: height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 1.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.05,
              alignment: Alignment.center,
              child: Icon(
                variety,
                color: Color(0XFFA49F94),
                size: 25 * screenRadio,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.36,
                    height: height * 0.03,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: stockPercent.floor(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              stockPercent.toStringAsFixed(1) + "%",
                              style: TextStyle(
                                  color: Colors.red[200],
                                  fontSize: 15 * screenRadio),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: loanPercent.floor(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              loanPercent.toStringAsFixed(1) + "%",
                              style: TextStyle(
                                  color: Colors.purple[200],
                                  fontSize: 15 * screenRadio),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: washPercent.floor(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              washPercent.toStringAsFixed(1) + "%",
                              style: TextStyle(
                                  color: Colors.cyan[300],
                                  fontSize: 15 * screenRadio),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.36,
                    height: height * 0.02,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: stockPercent.floor(),
                          child: Container(
                            color: Colors.red[100],
                          ),
                        ),
                        Expanded(
                          flex: loanPercent.floor(),
                          child: Container(
                            color: Colors.purple[100],
                          ),
                        ),
                        Expanded(
                          flex: washPercent.floor(),
                          child: Container(
                            color: Colors.cyan[100],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Container _stockTotalColumnBuilder(String status, int count) {
      Color txColor;
      if (status == "Laundry")
        txColor = Colors.cyan[300];
      else if (status == "Loan")
        txColor = Colors.purple[200];
      else
        txColor = Colors.red[200];
      return Container(
        child: Column(
          children: [
            Container(
              height: 50 * screenRadio,
              width: 50 * screenRadio,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(color: txColor, fontSize: 20 * screenRadio),
              ),
            ),
            Center(
              child: Text(
                '${Translations.of(context).text(status)}',
                style: TextStyle(color: txColor, fontSize: 15 * screenRadio),
              ),
            ),
          ],
        ),
      );
    }

    Container _eventCardBuilder(Event e) {
      String date = formatDate(e.date, [mm, "-", dd]);
      String time = formatDate(e.date, [HH, ':', nn]);
      Color bgColor;
      Color txColor;
      if ((e.date.day == DateTime.now().day) &&
          (e.date.month == DateTime.now().month) &&
          (e.date.year == DateTime.now().year)) {
        bgColor = Colors.purple[50];
        txColor = Colors.purple[200];
      } else if (e.date.weekday == 7) {
        bgColor = Colors.red[50];
        txColor = Colors.red[300];
      } else {
        bgColor = Colors.cyan[50];
        txColor = Colors.cyan[300];
      }

      return Container(
        margin: EdgeInsets.only(top: height * 0.01),
        padding: EdgeInsets.all(5 * screenRadio),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: txColor, fontSize: 12 * screenRadio),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 3 * screenRadio),
                      child: Icon(
                        Icons.attachment,
                        color: txColor,
                        size: 10 * screenRadio,
                      ),
                    ),
                    Text(
                      e.dis,
                      style:
                          TextStyle(color: txColor, fontSize: 8 * screenRadio),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              time,
              style: TextStyle(color: txColor, fontSize: 20 * screenRadio),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Translations.of(context).text("Home")}',
        ),
        actions: [
          LanguageSetting(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width * 0.45,
                height: height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //video playing
                    Container(
                      width: width * 0.45,
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                      ),
                      padding: EdgeInsets.all(10 * screenRadio),
                      child: playerVideo,
                    ),
                    Container(
                      width: width * 0.45,
                      height: height * 0.35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: width * 0.01,
                          color: Theme.of(context).cardColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: height * 0.01),
                            margin:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                )
                              ],
                            ),
                            width: width * 0.25,
                            child: dph.CustomDayPicker(
                              events: events,
                              width: width * 0.2,
                              height: height * 0.35,
                              onDateChange: (v) {
                                setState(() {
                                  this.selectedDate = v;
                                  this.date =
                                      formatDate(v, [yyyy, "-", mm, "-", dd]);
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.15,
                            height: height * 0.38,
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.15,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0XFFA49F94),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${Translations.of(context).text("Event Menu")}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18 * screenRadio),
                                  ),
                                ),
                                Container(
                                  width: width * 0.15,
                                  height: height * 0.24,
                                  child: ListView.builder(
                                      itemCount: events.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _eventCardBuilder(events[index]);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.45,
                height: height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.45,
                      height: height * 0.55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: EdgeInsets.all(width * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _stockCardBuilder(
                                    ClothIcons.Tshirt, 40, 25, 75),
                                _stockCardBuilder(
                                    ClothIcons.Trousers, 50, 20, 80),
                                _stockCardBuilder(
                                    ClothIcons.Jacket, 25, 30, 95),
                                _stockCardBuilder(
                                    ClothIcons.Accessories, 75, 45, 180),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _stockTotalColumnBuilder("Stock", 390),
                                _stockTotalColumnBuilder("Loan", 160),
                                _stockTotalColumnBuilder("Laundry", 200),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //staff page
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              width: width * 0.21,
                              height: height * 0.2,
                              decoration: buttonBox,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.white,
                                    size: 50 * screenRadio,
                                  ),
                                  Text(
                                    '${Translations.of(context).text("Staff")}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20 * screenRadio),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show(
                                  status:
                                      '${Translations.of(context).text("Loading...")}');
                              Navigator.pushNamed(
                                context,
                                '/staff',
                              );
                            },
                          ),
                          //service provider page
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              width: width * 0.21,
                              height: height * 0.2,
                              decoration: buttonBox,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.widgets,
                                    color: Colors.white,
                                    size: 50 * screenRadio,
                                  ),
                                  Text(
                                    '${Translations.of(context).text("Service Provider")}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15 * screenRadio),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show(
                                  status:
                                      '${Translations.of(context).text("Loading...")}');
                              Navigator.pushNamed(
                                context,
                                '/service_provider',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Event> events = [
  Event(DateTime.now(), "Today event"),
  Event(DateTime.now().subtract(Duration(days: 3)), "Ev1"),
  Event(DateTime.now().subtract(Duration(days: 13)), "Ev2"),
  Event(DateTime.now().subtract(Duration(days: 30)), "Ev3"),
  Event(DateTime.now().add(Duration(days: 3)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 13)), "Ev5"),
  Event(DateTime.now().add(Duration(days: 30)), "Ev6"),
];
