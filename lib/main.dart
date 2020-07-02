import 'package:flutter/material.dart';
import 'package:rfidgateway/pages/home.dart';
import 'package:rfidgateway/pages/staff.dart';

import 'pages/scanConfirm.dart';
import 'pages/serviceProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RFID Gateway',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Center(
        child: Home(),
      ),
    );
  }
}

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Center(
            child: Staff(),
          ),
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: 20, top: 20),
            alignment: Alignment.topLeft,
            child: FlatButton(
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
          ),
        ],
      ),
    );
  }
}

class ServiceProviderPage extends StatefulWidget {
  @override
  _ServiceProviderPageState createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Center(
            child: ServiceProvider(),
          ),
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: 20, top: 20),
            alignment: Alignment.topLeft,
            child: FlatButton(
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
          ),
        ],
      ),
    );
  }
}

class ScanConfirmPage extends StatefulWidget {
  @override
  _ScanConfirmPageState createState() => _ScanConfirmPageState();
}

class _ScanConfirmPageState extends State<ScanConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Center(
            child: ScanConfirm(),
          ),
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(left: 20, top: 20),
            alignment: Alignment.topLeft,
            child: FlatButton(
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
          ),
        ],
      ),
    );
  }
}
