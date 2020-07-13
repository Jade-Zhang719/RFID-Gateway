import 'dart:ui';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<Locale> supportedLanguages = [
    Locale('tw', ''),
    Locale('zh', ''),
    Locale('en', '')
  ];

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => lang);

  LocaleChangeCallback onLocaleChanged;

  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();
}

APPLIC applic = new APPLIC();
