import 'dart:math';

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

    double screenRadio = [width / 960, height / 552].reduce(min);

    Container _languageSettingButtonBulder(String language, String lanCode) {
      return Container(
        width: 50 * screenRadio,
        child: FlatButton(
          child: Text(
            language,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15 * screenRadio,
            ),
          ),
          onPressed: () {
            setState(() {
              changeLanguage(Locale(lanCode, ""));
            });
          },
        ),
      );
    }

    return Container(
      child: Translations.currentLocale == Locale("en", "")
          ? Row(
              children: [
                _languageSettingButtonBulder("繁", "tw"),
                _languageSettingButtonBulder("简", "zh"),
              ],
            )
          : (Translations.currentLocale == Locale("tw", "")
              ? Row(
                  children: [
                    _languageSettingButtonBulder("EN", "en"),
                    _languageSettingButtonBulder("简", "zh"),
                  ],
                )
              : Row(
                  children: [
                    _languageSettingButtonBulder("繁", "tw"),
                    _languageSettingButtonBulder("EN", "en"),
                  ],
                )),
    );
  }
}
