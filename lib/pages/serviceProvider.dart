import 'package:flutter/material.dart';

import '../main.dart';

class ServiceProvider extends StatefulWidget {
  @override
  _ServiceProviderState createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width * 0.9,
          height: height * 0.7,
          alignment: Alignment.center,
          child: Text(
            "Select Order",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
        Container(
          child: FlatButton(
            child: Container(
              width: width * 0.4,
              height: height * 0.1,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Text(
                "Scan",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ScanConfirmPage(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
