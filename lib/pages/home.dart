import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'chart.dart';
import 'serviceProvider.dart';
import 'staff.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VideoPlayerController _controller;
  // @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //       "http://dsm.retail-sys.com/Uploads/Medias/Applepromovideo-iPhone5cRetailStoreLaunch(2013)-YouTube(720p).mp4")
  //     ..initialize().then((_) {
  //       setState(() {});
  //     });
  //   super.initState();
  // }

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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //video playing
              Container(
                width: width * 0.45,
                height: height * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                // child: _controller.value.initialized
                //     ? AspectRatio(
                //         aspectRatio: _controller.value.aspectRatio,
                //         child: VideoPlayer(_controller),
                //       )
                //     : Container(),
              ),

              Container(
                width: width * 0.45,
                height: height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //chart
                    Container(
                      width: width * 0.45,
                      height: height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: charts.BarChart(
                        _getWeeklyRecordsData(),
                        animate: true,
                        domainAxis: charts.OrdinalAxisSpec(
                            renderSpec: charts.SmallTickRendererSpec(
                                labelRotation: 60)),
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
                            height: height * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue,
                            ),
                            child: FlatButton(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                    Text(
                                      "Staff",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40 * screenRadio),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
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
                            height: height * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue,
                            ),
                            child: FlatButton(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.widgets,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                    Text(
                                      "Service Provider",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25 * screenRadio),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
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
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}

_getWeeklyRecordsData() {
  List<charts.Series<WeeklyRecords, String>> weeklyRecords = [
    charts.Series(
      id: "Counts",
      data: data,
      domainFn: (WeeklyRecords weeklyRecords, _) => weeklyRecords.day,
      measureFn: (WeeklyRecords weeklyRecords, _) => weeklyRecords.counts,
    )
  ];
  return weeklyRecords;
}
