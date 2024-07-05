#### Country and city picker library Crafted by the **[UNICODE Team](https://www.unicodesolutions.co/)**

A Light-weight Flutter package for country and city picking, supporting English and Arabic seamlessly 🇸🇦💙🇧🇩❤️🇪🇬

# **Features support**

- **isoCode:** The ISO code of the country.
- **name:** The name of the country in Arabic.
- **dialCode:** The dial code of the country.
- **nameEn:** The name of the country in English.
- **flag:** The flag of the country represented as a Unicode emoji (e.g., 🇸🇦 for Saudi Arabia, and 🇧🇩 for Bangladesh).
- **cities:** A list of cities within the country.
- **phoneDigitsLength:** The length of phone number digits specific to the country (e.g., Saudi Arabia 🇸🇦 uses 9 digits).
- **phoneDigitsLengthMax:** The maximum length of phone number digits allowed in the country (e.g., Saudi Arabia 🇸🇦 allows up to 10 digits).

<img src="https://raw.githubusercontent.com/UNICODE-Venture/uni_country_city_picker/main/assets/screenshots/1.png" alt="UniCountryCityPicker by Saif">

## Getting started

Please have a look at our [/example](https://pub.dev/packages/uni_country_city_picker/example) project for a better understanding of implementations.

```dart
// [UniCountryServices] is a class that provides services to get countries and cities.
final _uniCountryServices = UniCountryServices.instance;
List<Country> countriesAndCities = await _uniCountryServices.getCountriesAndCities();
```

## Example with an widget

```dart
/// [UniCountryServices] is a class that provides services for countries and cities.
final _uniCountryServices = UniCountryServices.instance;

class CountriesAndCitiesView extends StatefulWidget {
  const CountriesAndCitiesView({super.key});

  @override
  State<CountriesAndCitiesView> createState() => _CountriesAndCitiesViewState();
}

class _CountriesAndCitiesViewState extends State<CountriesAndCitiesView> {
  /// List of countries and cities
  List<Country> countriesAndCities = [];

  @override
  void initState() {
    super.initState();
    // Get the countries and cities on init of the view
    _getCountriesAndCities();
  }

  /// Get the countries and cities from the package
  Future _getCountriesAndCities() async {
    countriesAndCities = await _uniCountryServices.getCountriesAndCities();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Uni Country City Picker")),
      body: ListView.builder(
          itemCount: countriesAndCities.length,
          itemBuilder: (_, i) {
            Country country = countriesAndCities[i];
            return ListTile(
              onTap: () => print(country.toMap()),
              title: Text(
                "${country.nameEn} (${country.flag}${country.dialCode})",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
    );
  }
}
```
