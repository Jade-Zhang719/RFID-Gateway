import 'package:flutter/material.dart';

import '../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width * 0.45,
          height: height * 0.9,
          decoration: BoxDecoration(
            border: Border.all(),
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
                height: height * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.21,
                      height: height * 0.4,
                      decoration: BoxDecoration(
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
                                    color: Colors.white, fontSize: 40),
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
                    Container(
                      width: width * 0.21,
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent[100],
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
                                    color: Colors.white, fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new ServiceProviderPage(),
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
    );
  }
}
