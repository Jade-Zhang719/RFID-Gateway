import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rfidgateway/pages/clothEnquiry.dart';

import 'language/translation/application.dart';
import 'language/translation/localization.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Translations.currentLocale = Locale("en", "");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    applic.onLocaleChanged = onLocaleChange;
    super.didChangeDependencies();
  }

  onLocaleChange(Locale locale) async {
    print('change lan: ' + locale.toString());
    await Translations.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: OKToast(
        dismissOtherOnShow: true,
        child: MaterialApp(
          locale: Locale("en", ""),
          localizationsDelegates: [
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: applic.supportedLocales(),
          title: "RFID Gateway",
          initialRoute: '/',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0XFF8d836f),
            accentColor: Color(0xFFd2c7bb),
            cardColor: Color(0xFFe1dcd6),
            scaffoldBackgroundColor: Color(0xFFf4f3f1),
          ),
          home: HomePage(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => new HomePage(),
            '/staff': (BuildContext context) => new StaffPage(),
            '/service_provider': (BuildContext context) =>
                new ServiceProviderPage(),
            '/cloth_enquiry': (BuildContext context) => new ClothEnquiryPage(),
          },
        ),
      ),
    );
  }
}
