class City {
  /// [name] is the name of the city in the local language Arabic.
  late String name;

  /// [code] is the code of the city.
  late String code;

  /// [nameEn] is the name of the city in English.
  late String nameEn;

  /// [City] is a class that contains the city's name in Arabic, code, and name in English.
  City({
    required this.name,
    required this.code,
    required this.nameEn,
  });

  /// [City.fromMap] is a factory method that creates a [City] instance from a map.
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
      code: map['code'],
      nameEn: map['nameEn'],
    );
  }

  /// [City.toMap] is a method that converts a [City] instance into a map.
  Map<String, dynamic> toMap() => {
        'name': name,
        'code': code,
        'nameEn': nameEn,
      };
}
