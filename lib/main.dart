import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

import 'pages/home.dart';
import 'pages/serviceProvider.dart';
import 'pages/staff.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Color(0xFF9c7356)
    ..backgroundColor = Color(0xFF8f897b)
    ..indicatorColor = Color(0xFF9c7356)
    ..textColor = Color(0xFF9c7356)
    ..maskColor = Color(0xFFe6d3ac).withOpacity(0.5)
    ..userInteractions = true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: OKToast(
        dismissOtherOnShow: true,
        child: MaterialApp(
          title: 'RFID Gateway',
          initialRoute: '/',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xFF9c7356),
            accentColor: Color(0xFF8f897b),
            scaffoldBackgroundColor: Color(0xFFe6d3ac),
          ),
          home: HomePage(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => new HomePage(),
            '/staff': (BuildContext context) => new StaffPage(),
            '/service_provider': (BuildContext context) =>
                new ServiceProviderPage(),
          },
        ),
      ),
    );
  }
}
