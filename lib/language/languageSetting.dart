import 'dart:math';

import 'package:flutter/material.dart';

import 'translation/application.dart';

List<String> languages = ["EN", "简", "繁"];

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  Future<void> changeLanguage(Locale locale) async {
    applic.onLocaleChanged(locale);
  }

  String dropdownValue = "EN";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double screenRadio = [width / 960, height / 552].reduce(min);

    return Container(
      margin: EdgeInsets.only(right: 10 * screenRadio),
      child: DropdownButton<String>(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        iconEnabledColor: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        iconSize: 30 * screenRadio,
        // value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            if (newValue == "EN")
              changeLanguage(Locale("en", ""));
            else if (newValue == "简")
              changeLanguage(Locale("zh", ""));
            else
              changeLanguage(Locale("tw", ""));
          });
        },
        underline: Container(),
        items: languages.map<DropdownMenuItem<String>>((String language) {
          return DropdownMenuItem<String>(
            value: language,
            child: Container(
              width: 40 * screenRadio,
              alignment: Alignment.center,
              child: Text(
                language,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15 * screenRadio),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
