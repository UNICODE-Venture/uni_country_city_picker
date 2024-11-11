import 'dart:ui';

import 'package:uni_country_city_picker/src/utils/locale.dart';

enum UniLocale {
  ar,
  en;

  /// Get current locale `ar_SA` or `en_US`
  Locale get currentLocale => this == UniLocale.ar
      ? LocalizationsData.supportLocale.first
      : LocalizationsData.supportLocale.last;

  /// Check if the locale is `Arabic`
  bool get isArabic => this == UniLocale.ar;

  /// Check if the locale is `English`
  bool get isEnglish => this == UniLocale.en;

  /// Get the locale code
  String get localeCode {
    switch (this) {
      case UniLocale.ar:
        return "ar_SA";
      case UniLocale.en:
        return "en_US";
      default:
        return "en_US";
    }
  }
}
