import 'package:chewie/chewie.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:video_player/video_player.dart';

import '../calendar/dayPickerForHome.dart' as dph;
import '../calendar/event.dart';
import '../language/languageSetting.dart';
import '../language/translation/localization.dart';

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
      Color(0XFFA49F94),
      Color(0XFFA49F94),
      Colors.grey[400],
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
);

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

    double screenRadio = width / 961.5;

    Container _stockCardBuilder(String variety, int loan, int wash, int stock) {
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
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.03,
              height: height * 0.07,
              alignment: Alignment.center,
              margin: EdgeInsets.all(height * 0.005 * screenRadio),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0XFFA49F94),
              ),
              child: Image.asset(
                'assets/cloth_icon/$variety.png',
                width: 30 * screenRadio,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.36,
                    height: height * 0.03,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: loanPercent.floor(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              loanPercent.toStringAsFixed(1) + "%",
                              style: TextStyle(
                                  color: Colors.cyan[300],
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
                                  color: Colors.purple[200],
                                  fontSize: 15 * screenRadio),
                            ),
                          ),
                        ),
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
                          flex: loanPercent.floor(),
                          child: Container(
                            color: Colors.cyan[100],
                          ),
                        ),
                        Expanded(
                          flex: washPercent.floor(),
                          child: Container(
                            color: Colors.purple[100],
                          ),
                        ),
                        Expanded(
                          flex: stockPercent.floor(),
                          child: Container(
                            color: Colors.red[100],
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
      if (status == "Loan")
        txColor = Colors.cyan[300];
      else if (status == "Wash")
        txColor = Colors.purple[200];
      else
        txColor = Colors.red[200];
      return Container(
        child: Column(
          children: [
            Center(
              child: Text(
                '${Translations.of(context).text(status)}',
                style: TextStyle(color: txColor, fontSize: 15 * screenRadio),
              ),
            ),
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
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${Translations.of(context).text("Home")}'),
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
                                  color: Color(0XFFA49F94),
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
                                        return Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          padding:
                                              EdgeInsets.all(5 * screenRadio),
                                          color: ((events[index].date.day ==
                                                      DateTime.now().day) &&
                                                  (events[index].date.month ==
                                                      DateTime.now().month) &&
                                                  (events[index].date.year ==
                                                      DateTime.now().year))
                                              ? Colors.purple[50]
                                              : (events[index].date.weekday ==
                                                      7)
                                                  ? Colors.red[50]
                                                  : Colors.cyan[50],
                                          child: Column(
                                            children: [
                                              Text(
                                                formatDate(events[index].date,
                                                    [yyyy, "-", mm, "-", dd]),
                                                style: TextStyle(
                                                    color: ((events[index]
                                                                    .date
                                                                    .day ==
                                                                DateTime.now()
                                                                    .day) &&
                                                            (events[index]
                                                                    .date
                                                                    .month ==
                                                                DateTime.now()
                                                                    .month) &&
                                                            (events[index]
                                                                    .date
                                                                    .year ==
                                                                DateTime.now()
                                                                    .year))
                                                        ? Colors.purple[200]
                                                        : (events[index]
                                                                    .date
                                                                    .weekday ==
                                                                7)
                                                            ? Colors.red[300]
                                                            : Colors.cyan[300],
                                                    fontSize: 10 * screenRadio),
                                              ),
                                              Text(
                                                events[index].dis,
                                                style: TextStyle(
                                                    color: ((events[index]
                                                                    .date
                                                                    .day ==
                                                                DateTime.now()
                                                                    .day) &&
                                                            (events[index]
                                                                    .date
                                                                    .month ==
                                                                DateTime.now()
                                                                    .month) &&
                                                            (events[index]
                                                                    .date
                                                                    .year ==
                                                                DateTime.now()
                                                                    .year))
                                                        ? Colors.purple[200]
                                                        : (events[index]
                                                                    .date
                                                                    .weekday ==
                                                                7)
                                                            ? Colors.red[300]
                                                            : Colors.cyan[300],
                                                    fontSize: 10 * screenRadio),
                                              ),
                                            ],
                                          ),
                                        );
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
                        children: [
                          Container(
                            height: height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _stockCardBuilder("T-shirt", 40, 25, 75),
                                _stockCardBuilder("Trousers", 50, 20, 80),
                                _stockCardBuilder("Jacket", 25, 30, 95),
                                _stockCardBuilder("Accessories", 75, 45, 180),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.02),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${Translations.of(context).text("Total:")}',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20 * screenRadio),
                                  ),
                                ),
                                _stockTotalColumnBuilder("Loan", 200),
                                _stockTotalColumnBuilder("Wash", 160),
                                _stockTotalColumnBuilder("Stock", 390),
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
                                      '${Translations.of(context).text("loading...")}');
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
                                      '${Translations.of(context).text("loading...")}');
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
  Event(DateTime.now().subtract(Duration(days: 2)), "Ev1"),
  Event(DateTime.now().subtract(Duration(days: 13)), "Ev2"),
  Event(DateTime.now().subtract(Duration(days: 30)), "Ev3"),
  Event(DateTime.now().add(Duration(days: 3)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 13)), "Ev5"),
  Event(DateTime.now().add(Duration(days: 30)), "Ev6"),
];
