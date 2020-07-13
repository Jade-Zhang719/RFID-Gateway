import 'package:flutter/material.dart';

import 'translation/application.dart';
import 'translation/localization.dart';

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  Future<void> changeLanguage(Locale locale) async {
    applic.onLocaleChanged(locale);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double screenRadio = width / 961.5;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Translations.currentLocale == Locale("en", "")
              ? Container()
              : FlatButton(
                  child: Text(
                    "EN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * screenRadio,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      changeLanguage(Locale("en", ""));
                    });
                  },
                ),
          Translations.currentLocale == Locale("en", "")
              ? Container()
              : Container(
                  height: height * 0.06,
                  child: VerticalDivider(
                    color: Colors.white,
                  ),
                ),
          Translations.currentLocale == Locale("tw", "")
              ? Container()
              : FlatButton(
                  child: Text(
                    "繁",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * screenRadio,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      changeLanguage(Locale("tw", ""));
                    });
                  },
                ),
          Translations.currentLocale == Locale("en", "")
              ? Container(
                  height: height * 0.06,
                  child: VerticalDivider(
                    color: Colors.white,
                  ),
                )
              : Container(),
          Translations.currentLocale == Locale("zh", "")
              ? Container()
              : FlatButton(
                  child: Text(
                    "简",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * screenRadio,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      changeLanguage(Locale("zh", ""));
                    });
                  },
                ),
        ],
      ),
    );
  }
}
