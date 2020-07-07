import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../charts/stockPieChart.dart';
import 'serviceProvider.dart';
import 'staff.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //video
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie playerWidget;

  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        'http://dsm.retail-sys.com/Uploads/Medias/Applepromovideo-iPhone5cRetailStoreLaunch(2013)-YouTube(720p).mp4');
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

    //order table row
    TableRow _tableRowBuilder(
        String orderNo, String ltime, String rtime, String statues) {
      return TableRow(
        children: [
          Container(
            padding: EdgeInsets.all(5 * screenRadio),
            alignment: Alignment.center,
            child: Text(
              orderNo,
              style: TextStyle(color: Colors.white, fontSize: 10 * screenRadio),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5 * screenRadio),
            alignment: Alignment.center,
            child: Text(
              ltime,
              style: TextStyle(color: Colors.white, fontSize: 10 * screenRadio),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5 * screenRadio),
            alignment: Alignment.center,
            child: Text(
              rtime,
              style: TextStyle(color: Colors.white, fontSize: 10 * screenRadio),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5 * screenRadio),
            alignment: Alignment.center,
            child: Text(
              statues,
              style: TextStyle(color: Colors.white, fontSize: 10 * screenRadio),
            ),
          ),
        ],
      );
    }

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
                child: playerWidget,
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
                        color: Colors.lightBlue,
                      ),
                      padding: EdgeInsets.all(width * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.43,
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10 * screenRadio),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: width * 0.08,
                                  child: drawPieChart(
                                      "T-shirt Stock", tShirtStock),
                                ),
                                Container(
                                  width: width * 0.08,
                                  child:
                                      drawPieChart("Trousers", trousersStock),
                                ),
                                Container(
                                  width: width * 0.08,
                                  child: drawPieChart("Jacket", jacketStock),
                                ),
                                Container(
                                  width: width * 0.08,
                                  child: drawPieChart(
                                      "Accessories", accessoriesStock),
                                ),
                                Container(
                                  width: width * 0.08,
                                  child:
                                      drawPieChart("Total Stock", totalStock),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.43,
                            height: height * 0.25,
                            child: Table(
                              border: TableBorder.all(color: Colors.white),
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5 * screenRadio),
                                      alignment: Alignment.center,
                                      color: Colors.pink[200],
                                      child: Text(
                                        "Order No.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10 * screenRadio),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5 * screenRadio),
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text(
                                        "Leave Time",
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 10 * screenRadio),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5 * screenRadio),
                                      alignment: Alignment.center,
                                      color: Colors.pink[200],
                                      child: Text(
                                        "Return Time",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10 * screenRadio),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5 * screenRadio),
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 10 * screenRadio),
                                      ),
                                    ),
                                  ],
                                ),
                                _tableRowBuilder("1", "05/07/2020, 10:20",
                                    "06/07/2020, 15:30", "Finish"),
                                _tableRowBuilder("2", "06/07/2020, 11:10", "-",
                                    "In Progress"),
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
                              color: Colors.pink[200],
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
}
