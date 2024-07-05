import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni Country City Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CountriesAndCitiesView(),
    );
  }
}

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
