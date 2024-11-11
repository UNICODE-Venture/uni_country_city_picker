// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uni_country_city_picker/src/constants/uni_text.dart';
import 'package:uni_country_city_picker/src/core/features/widgets/uni_widgets.dart';
import 'package:uni_country_city_picker/src/core/style/uni_style.dart';
import 'package:uni_country_city_picker/src/utils/enums.dart';
import 'package:uni_country_city_picker/src/utils/locale.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';

/// [UniCountryServices] is a class that provides services for countries and cities.
final _uniCountryServices = UniCountryServices.instance;

class CountrySelectionBottomSheet extends StatefulWidget {
  /// [ISO] code of the country to be selected initially
  final String? initialCounryIsoCode;

  /// Callback function to return the selected country's [ISO] code
  final Function(Country?)? seletedCountry;

  /// List of [ISO] codes to prioritize at the top of the list
  final List<String> prioritizedIsoCodes;

  /// The locale of the bottom sheet
  final UniLocale locale;

  const CountrySelectionBottomSheet({
    super.key,
    this.initialCounryIsoCode,
    this.seletedCountry,
    this.locale = UniLocale.en,
    this.prioritizedIsoCodes = const [
      'SA',
      'AE',
      'KW',
      'QA',
      'BH',
      'PS',
      'EG',
      'BD'
    ], // Default prioritized countries
  });

  @override
  State<CountrySelectionBottomSheet> createState() =>
      _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState
    extends State<CountrySelectionBottomSheet> {
  List<Country> prioritizedCountries = [];
  Map<String, List<Country>> groupedCountries = {};
  Map<String, List<Country>> filteredCountries = {};
  String? selectedCountryIsoCode;
  bool isSearching = false;
  Country? previouslySelectedCountry;
  String? previousCountryGroupKey;
  List<Country> countriesList = [];

  Future<void> getCountriesAndCities() async {
    selectedCountryIsoCode = widget.initialCounryIsoCode;
    countriesList = await _uniCountryServices.getCountriesAndCities();
  }

  initMethid() async {
    await getCountriesAndCities();
    groupCountries([...countriesList]);
    filteredCountries = groupedCountries;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initMethid();
  }

  void groupCountries(List<Country> countries) {
    countries.sort((a, b) => a.name.compareTo(b.name));

    // Use the provided prioritized ISO codes or default to "SA" and "PS"
    for (var isoCode in widget.prioritizedIsoCodes) {
      Country? country =
          countries.firstWhereOrNull((c) => c.isoCode == isoCode);
      if (country != null) {
        prioritizedCountries.add(country);
      }
      countries.removeWhere((c) => c.isoCode == isoCode);
    }

    // Now group the remaining countries alphabetically
    for (var country in countries) {
      String firstLetter = country.name[0].toUpperCase();
      if (groupedCountries[firstLetter] == null) {
        groupedCountries[firstLetter] = [];
      }
      groupedCountries[firstLetter]!.add(country);
    }
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        filteredCountries = groupedCountries;
      });
    } else {
      setState(() {
        isSearching = true;
      });

      Map<String, List<Country>> tempFilteredCountries = {};

      // Ensure prioritized countries are included in the search results if they match the query
      List<Country> prioritizedList = prioritizedCountries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.nameEn.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (prioritizedList.isNotEmpty) {
        tempFilteredCountries[""] =
            prioritizedList; // "" will ensure they appear at the top
      }

      groupedCountries.forEach((key, countries) {
        var filteredList = countries
            .where((country) =>
                country.name.contains(query) || country.nameEn.contains(query))
            .toList();
        if (filteredList.isNotEmpty) {
          tempFilteredCountries[key] = filteredList;
        }
      });

      setState(() {
        filteredCountries = tempFilteredCountries;
      });
    }
  }

  void selectCountry(Country country) {
    setState(() {
      // If a prioritized country is selected, prioritize it and remove others from the top
      if (widget.prioritizedIsoCodes.contains(country.isoCode)) {
        // Reinsert the previous country back to its original position if it exists
        if (previouslySelectedCountry != null &&
            previousCountryGroupKey != null) {
          groupedCountries[previousCountryGroupKey!]
              ?.add(previouslySelectedCountry!);
          groupedCountries[previousCountryGroupKey!]!
              .sort((a, b) => a.name.compareTo(b.name));
          previouslySelectedCountry = null;
          previousCountryGroupKey = null;
        }

        prioritizedCountries.removeWhere(
            (c) => !widget.prioritizedIsoCodes.contains(c.isoCode));
        selectedCountryIsoCode = country.isoCode;
        previouslySelectedCountry = null;
      } else {
        // If another country is selected, move it to the top and remove it from its original position
        if (previouslySelectedCountry != null &&
            previousCountryGroupKey != null) {
          // Reinsert the previously selected country back to its original position
          groupedCountries[previousCountryGroupKey!]
              ?.add(previouslySelectedCountry!);
          groupedCountries[previousCountryGroupKey!]!
              .sort((a, b) => a.name.compareTo(b.name));
        }

        // Store the current selected country and its group key before moving it
        previouslySelectedCountry = country;
        previousCountryGroupKey = country.name[0].toUpperCase();

        // Remove the selected country from its original position
        groupedCountries[previousCountryGroupKey!]
            ?.removeWhere((c) => c.isoCode == country.isoCode);

        // Move the selected country to the top
        prioritizedCountries.removeWhere(
            (c) => !widget.prioritizedIsoCodes.contains(c.isoCode));
        prioritizedCountries.insert(0, country);
        selectedCountryIsoCode = country.isoCode;
      }

      // Clear search and reset the filtered list
      filterCountries("");
    });
  }

  @override
  Widget build(BuildContext context) {
    UniText.isEnglish = widget.locale.isEnglish;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LocalizationsData.localizationsDelegate,
      supportedLocales: LocalizationsData.supportLocale,
      locale: widget.locale.currentLocale,
      home: Column(
        children: [
          Padding(
            padding:
                const EdgeInsetsDirectional.only(start: 20, top: 30, end: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: UniWidgets.closeButton(
                      onTap: () {
                        widget.seletedCountry!(null);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Center(
                    child: Text(UniText.chooseTheCountry,
                        style: UniStyle.s_16_400
                            .copyWith(color: UniStyle.loud900)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () {
                        widget.seletedCountry!(countriesList.firstWhereOrNull(
                            (country) =>
                                country.isoCode == selectedCountryIsoCode));
                        Navigator.pop(context);
                      },
                      child: Text(UniText.apply,
                          style: UniStyle.s_15_400
                              .copyWith(color: UniStyle.primary100)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          UniWidgets.verticalSpace(14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: UniStyle.normal25,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(maxWidth: 28, maxHeight: 20),
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child:
                      UniWidgets.svgIcon('search', color: UniStyle.normal500),
                ),
                hintText: UniText.searchTheCountry,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                filterCountries(value);
              },
            ),
          ),
          const SizedBox(height: 16),
          //! Countries List ----------------------------------------------
          Expanded(
            child: ListView.builder(
              itemCount: isSearching
                  ? filteredCountries.keys.length
                  : prioritizedCountries.length + filteredCountries.keys.length,
              itemBuilder: (context, index) {
                // Handle prioritized countries at the top when not searching
                if (!isSearching && index < prioritizedCountries.length) {
                  Country country = prioritizedCountries[index];
                  return buildCountryTile(country);
                }

                // Handle remaining countries alphabetically
                int adjustedIndex =
                    isSearching ? index : index - prioritizedCountries.length;
                String key = filteredCountries.keys.elementAt(adjustedIndex);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (key
                        .isNotEmpty) // Prevent empty header for prioritized countries in search
                      Container(
                        width: double.infinity,
                        color: UniStyle.normal25,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 22),
                        child: Text(
                          key,
                          style: UniStyle.s_14_400
                              .copyWith(color: UniStyle.darkGreen),
                        ),
                      ),
                    ...filteredCountries[key]!.map((country) {
                      return buildCountryTile(country);
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCountryTile(Country country) {
    return InkWell(
      onTap: () {
        selectCountry(country);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 16,
            ),
            child: Row(
              children: [
                Text(
                  country.flag,
                  style: const TextStyle(fontSize: 26),
                ),
                UniWidgets.horizontalSpace(14),
                Text(
                  UniText.isEnglish ? country.nameEn : country.name,
                  style: UniStyle.s_14_400.copyWith(color: UniStyle.muted600),
                ),
                const Spacer(),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: selectedCountryIsoCode == country.isoCode
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild:
                      UniWidgets.svgIcon('check', color: UniStyle.primary100),
                  secondChild:
                      UniWidgets.svgIcon('check', color: Colors.transparent),
                ),
              ],
            ),
          ),
          // if not last in prioritized or filtered list, show divider
          if (country != prioritizedCountries.last &&
              country != filteredCountries[filteredCountries.keys.last]!.last)
            Container(
              margin: const EdgeInsetsDirectional.only(start: 60),
              height: 1,
              width: double.infinity,
              color: UniStyle.disabled25,
            ),
        ],
      ),
    );
  }
}
