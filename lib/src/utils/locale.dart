import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationsData {
  LocalizationsData._();
  static List<LocalizationsDelegate> localizationsDelegate = const [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static List<Locale> supportLocale = const [
    Locale("ar", "SA"),
    Locale("en", "US"),
  ];
}
