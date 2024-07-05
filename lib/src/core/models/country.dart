import 'city.dart';

/// [Country] is a class that contains the country's ISO code, name in Arabic, dial code, name in English, flag (🇸🇦💙🇧🇩), phone number digits length and their list of cities.
class Country {
  /// [isoCode] is the ISO code of the country.
  late String isoCode;

  /// [name] is the name of the country in the local language Arabic.
  late String name;

  /// [dialCode] is the dial code of the country.
  late String dialCode;

  /// [nameEn] is the name of the country in English.
  late String nameEn;

  /// [flag] is the flag of the country, as an unicode emoji character e.g: 🇸🇦 for Saudi Arabia, and 🇧🇩 for Bangladesh.
  late String flag;

  /// [cities] is a list of cities in the country.
  late List<City> cities;

  /// [phoneDigitsLength] is the length of the phone number digits provided by their country, e,g: (Saudi Arabia 🇸🇦) is 9 digits.
  late int phoneDigitsLength;

  /// [phoneDigitsLengthMax] is the length of the phone number digits provided by their country, e,g: (Saudi Arabia 🇸🇦)'s max is 10 digits.
  late int phoneDigitsLengthMax;

  /// [Country] is a class that contains the country's ISO code, name in Arabic, dial code, name in English, flag (🇸🇦💙🇧🇩), phone number digits length and their list of cities.
  Country({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.nameEn,
    required this.flag,
    required this.cities,
    required this.phoneDigitsLength,
    required this.phoneDigitsLengthMax,
  });

  /// [Country.fromMap] is a factory method that creates a [Country] instance from a map.
  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      isoCode: map['isoCode'],
      name: map['name'],
      dialCode: map['dialCode'],
      nameEn: map['nameEn'],
      flag: map['flag'],
      cities: (map['cities'] as List).map((e) => City.fromMap(e)).toList(),
      phoneDigitsLength: map['phoneDigitsLength'] ?? 0,
      phoneDigitsLengthMax: map['phoneDigitsLengthMax'] ?? 0,
    );
  }

  /// [Country.toMap] is a method that converts a [Country] instance into a map.
  Map<String, dynamic> toMap() => {
        'isoCode': isoCode,
        'name': name,
        'dialCode': dialCode,
        'nameEn': nameEn,
        'flag': flag,
        'cities': cities.map((e) => e.toMap()).toList(),
        'phoneDigitsLength': phoneDigitsLength,
        'phoneDigitsLengthMax': phoneDigitsLengthMax,
      };
}
