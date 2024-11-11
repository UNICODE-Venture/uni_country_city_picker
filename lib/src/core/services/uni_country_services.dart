import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_country_city_picker/src/core/features/countries_bottom_sheet.dart';
import 'package:uni_country_city_picker/src/core/features/widgets/primary_cupertino_bottom_sheet.dart';
import 'package:uni_country_city_picker/src/utils/enums.dart';

import '../../constants/assets_path.dart';
import '../models/country.dart';

/// [UniCountryServices] is a class that provides services for countries and cities.
class UniCountryServices {
  UniCountryServices();
  static UniCountryServices? _instance;

  /// [instance] is a singleton instance of [UniCountryServices].
  static UniCountryServices get instance => _instance ??= UniCountryServices();

  /// [_countriesAndCities] is a list of countries, and their cities, in [Country] format that saves to memory on first call and returns on subsequent calls to save memory and speed up the process.
  List<Country>? _countriesAndCities;

  /// [getCountriesAndCities] is a method that returns a list of countries, and their cities, in [Country] format.
  ///
  /// [Country] is a class that contains the country's ISO code, name in Arabic, dial code, name in English, flag (🇸🇦💙🇧🇩), phone number digits length and their list of cities.
  Future<List<Country>> getCountriesAndCities() async {
    return _countriesAndCities ??=
        await readTheCountriesAndCitiesDatabaseFile();
  }

  /// [readTheCountriesAndCitiesDatabaseFile] is a method that reads the countries and cities database file from the assets
  Future<List<Country>> readTheCountriesAndCitiesDatabaseFile() async {
    List<Country> countriesAndCities = [];
    try {
      String encodedJsonData =
          await rootBundle.loadString(UniAssetsPath.countriesAndCities);
      List<dynamic> decodedJsonData = jsonDecode(encodedJsonData);
      countriesAndCities =
          decodedJsonData.map((c) => Country.fromMap(c)).toList();
    } catch (e) {
      return countriesAndCities;
    }
    return countriesAndCities;
  }

  Future<void> showCountryCityPicker({
    required BuildContext context,
    required Function(Country?)? onSelectedCountry,
    String? initialCounryIsoCode,
    UniLocale? locale,
  }) async {
    await primaryCupertinoBottomSheet(
      context: context,
      isShowCloseIcon: false,
      child: CountrySelectionBottomSheet(
        initialCounryIsoCode: initialCounryIsoCode,
        seletedCountry: onSelectedCountry,
        locale: locale ?? UniLocale.en,
      ),
    );
  }
}
