import 'package:charts_flutter/flutter.dart' as chart;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:video_player/video_player.dart';

import 'serviceProvider.dart';
import 'staff.dart';

class Stock {
  final String loan;
  final int qty;
  chart.Color pieColor;
  Stock(this.loan, this.qty, this.pieColor);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie playerWidget;
  List<Stock> tShirtStock;
  List<Stock> trousersStock;
  List<Stock> jacketStock;
  List<Stock> accessoriesStock;
  List<Stock> totalStock;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        'http://dsm.retail-sys.com/Uploads/Medias/Applepromovideo-iPhone5cRetailStoreLaunch(2013)-YouTube(720p).mp4');
    // _videoPlayerController =
    //     VideoPlayerController.asset('assets/rfid_homepage.mp4')
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

    tShirtStock = [
      Stock("Loaned", 150, chart.ColorUtil.fromDartColor(Color(0XFFd9b59c))),
      Stock("Remained", 50, chart.ColorUtil.fromDartColor(Color(0xFF9c7356))),
    ];
    trousersStock = [
      Stock("Loaned", 120, chart.ColorUtil.fromDartColor(Color(0XFFd9b59c))),
      Stock("Remained", 80, chart.ColorUtil.fromDartColor(Color(0xFF9c7356))),
    ];
    jacketStock = [
      Stock("Loaned", 70, chart.ColorUtil.fromDartColor(Color(0XFFd9b59c))),
      Stock("Remained", 130, chart.ColorUtil.fromDartColor(Color(0xFF9c7356))),
    ];
    accessoriesStock = [
      Stock("Loaned", 180, chart.ColorUtil.fromDartColor(Color(0XFFd9b59c))),
      Stock("Remained", 220, chart.ColorUtil.fromDartColor(Color(0xFF9c7356))),
    ];
    totalStock = [
      Stock("Loaned", 520, chart.ColorUtil.fromDartColor(Color(0xFFcccac4))),
      Stock("Remained", 480, chart.ColorUtil.fromDartColor(Color(0xFF8f897b))),
    ];

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

    chart.PieChart _drawPieChart(String id, List<Stock> stockList) {
      List<chart.Series<Stock, String>> seriesList = [
        chart.Series(
          id: id,
          data: stockList,
          domainFn: (Stock stockList, _) => stockList.loan,
          measureFn: (Stock stockList, _) => stockList.qty,
          colorFn: (Stock stockList, _) => stockList.pieColor,
          labelAccessorFn: (Stock stockList, _) =>
              '${stockList.loan}: ${stockList.qty.toString()}',
        )
      ];
      return chart.PieChart(
        seriesList,
        animate: false,
        defaultRenderer: new chart.ArcRendererConfig(
          arcWidth: 20 * screenRadio.floor(),
          arcRendererDecorators: [
            new chart.ArcLabelDecorator(
              labelPosition: chart.ArcLabelPosition.inside,
              insideLabelStyleSpec: new chart.TextStyleSpec(
                fontSize: 2 * screenRadio.floor(),
              ),
            ),
          ],
        ),
      );
    }

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
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10 * screenRadio),
                          child: Text(
                            "Landary Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20 * screenRadio),
                          ),
                        ),
                        Container(
                          width: width * 0.43,
                          height: height * 0.28,
                          child: ListView(
                            children: [
                              Table(
                                border: TableBorder.all(color: Colors.white),
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(5 * screenRadio),
                                        alignment: Alignment.center,
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          "Order No.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10 * screenRadio),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.all(5 * screenRadio),
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: Text(
                                          "Leave Time",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 10 * screenRadio),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.all(5 * screenRadio),
                                        alignment: Alignment.center,
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          "Return Time",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10 * screenRadio),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.all(5 * screenRadio),
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 10 * screenRadio),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _tableRowBuilder("1", "05/07/2020, 10:20",
                                      "06/07/2020, 15:30", "Finish"),
                                  _tableRowBuilder("2", "06/07/2020, 11:10",
                                      "-", "In Progress"),
                                  _tableRowBuilder("3", "", "", ""),
                                  _tableRowBuilder("4", "", "", ""),
                                  _tableRowBuilder("5", "", "", ""),
                                  _tableRowBuilder("6", "", "", ""),
                                  _tableRowBuilder("7", "", "", ""),
                                ],
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
              height: height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //chart
                  Container(
                    width: width * 0.45,
                    height: height * 0.45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor,
                    ),
                    padding: EdgeInsets.all(width * 0.01),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.45 - width * 0.02,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10 * screenRadio),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            Text("T-shirt",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 5 * screenRadio)),
                                            Container(
                                              width: width * 0.1,
                                              height: width * 0.1,
                                              child: _drawPieChart(
                                                  "T-shirt", tShirtStock),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("Trousers",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 5 * screenRadio)),
                                            Container(
                                              width: width * 0.1,
                                              height: width * 0.1,
                                              child: _drawPieChart(
                                                  "Trousers", trousersStock),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            Text("Jacket",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 5 * screenRadio)),
                                            Container(
                                              width: width * 0.1,
                                              height: width * 0.1,
                                              child: _drawPieChart(
                                                  "Jacket", jacketStock),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("Accessories",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 5 * screenRadio)),
                                            Container(
                                              width: width * 0.1,
                                              height: width * 0.1,
                                              child: _drawPieChart(
                                                  "Accessories",
                                                  accessoriesStock),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Total Stock",
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 10 * screenRadio)),
                                  Container(
                                    width: width * 0.2,
                                    height: height * 0.2,
                                    child: _drawPieChart(
                                        "Total Stock", totalStock),
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
                          height: height * 0.4,
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
                          height: height * 0.4,
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
