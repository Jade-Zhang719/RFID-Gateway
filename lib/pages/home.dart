import 'package:chewie/chewie.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rfidgateway/src/event.dart';
import 'package:video_player/video_player.dart';

import 'dayPicker.dart' as dp;
import 'serviceProvider.dart';
import 'staff.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie playerWidget;
  DateTime selectedDate;
  String date;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        'http://dsm.retail-sys.com/Uploads/Medias/Applepromovideo-iPhone5cRetailStoreLaunch(2013)-YouTube(720p).mp4');
    // _videoPlayerController =
    //     VideoPlayerController.asset('assets/video/rfid_homepage.mp4')
    //       ..initialize().then((_) {
    //         setState(() {});
    //       });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16.0 / 9.0,
      autoPlay: true,
      looping: true,
    );
    playerWidget = Chewie(
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
      return Container(
        child: Row(
          children: [
            Container(
              width: 65 * screenRadio,
              height: 65 * screenRadio,
              alignment: Alignment.center,
              margin: EdgeInsets.all(10 * screenRadio),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: Image.asset(
                'assets/cloth_icon/$variety.png',
                width: 45 * screenRadio,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loan: ${loan.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15 * screenRadio),
                  ),
                  Text(
                    "Wash: ${wash.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15 * screenRadio),
                  ),
                  Text(
                    "Stock: ${stock.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15 * screenRadio),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.45,
              height: height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //video playing
                  Container(
                      width: width * 0.45,
                      height: height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(10 * screenRadio),
                      child: playerWidget),
                  Container(
                    width: width * 0.45,
                    height: height * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Container(
                      width: width * 0.43,
                      height: height * 0.4 - 20 * screenRadio,
                      padding: EdgeInsets.only(top: height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: dp.CustomDayPicker(
                        events: events,
                        width: width * 0.38,
                        height: height * 0.38,
                        onDateChange: (v) {
                          setState(() {
                            this.selectedDate = v;
                            this.date = formatDate(v, [yyyy, "-", mm, "-", dd]);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.45,
              height: height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.45,
                    height: height * 0.55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor,
                    ),
                    padding: EdgeInsets.all(width * 0.01),
                    child: Column(
                      children: [
                        Container(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10 * screenRadio,
                            spacing: 15 * screenRadio,
                            children: [
                              Container(
                                width: width * 0.2,
                                height: height * 0.16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: _stockCardBuilder("T-shirt", 40, 20, 80),
                              ),
                              Container(
                                width: width * 0.2,
                                height: height * 0.16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child:
                                    _stockCardBuilder("Trousers", 40, 20, 80),
                              ),
                              Container(
                                width: width * 0.2,
                                height: height * 0.16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: _stockCardBuilder("Jacket", 40, 20, 80),
                              ),
                              Container(
                                width: width * 0.2,
                                height: height * 0.16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: _stockCardBuilder(
                                    "Accessories", 40, 20, 80),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.05),
                          alignment: Alignment.center,
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Container(),
                                  Center(
                                    child: Text(
                                      "Loan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15 * screenRadio),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Wash",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15 * screenRadio),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Stock",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15 * screenRadio),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Center(
                                    child: Text(
                                      "Total:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25 * screenRadio),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "160",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25 * screenRadio),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "80",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25 * screenRadio),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "120",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25 * screenRadio),
                                    ),
                                  ),
                                ],
                              ),
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
                        Container(
                          width: width * 0.21,
                          height: height * 0.3,
                          padding: EdgeInsets.all(10 * screenRadio),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: FlatButton(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.white,
                                    size: 60 * screenRadio,
                                  ),
                                  Text(
                                    "Staff",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30 * screenRadio),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show(status: 'loading...');
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new StaffPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        //service provider page
                        Container(
                          width: width * 0.21,
                          height: height * 0.3,
                          padding: EdgeInsets.all(10 * screenRadio),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: FlatButton(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.widgets,
                                    color: Colors.white,
                                    size: 60 * screenRadio,
                                  ),
                                  Text(
                                    "Service\nProvider",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18 * screenRadio),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show(status: 'loading...');
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) =>
                                      new ServiceProviderPage(),
                                ),
                              );
                            },
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
