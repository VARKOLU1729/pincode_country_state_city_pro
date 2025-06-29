import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pincode_country_state_city_pro/src/models/country.dart';

class CountryUtils {
  static List<Country> _cachedCountries = [];

  static Future<List<Country>> _loadCountries() async {
    if (_cachedCountries.isNotEmpty) {
      return _cachedCountries;
    }
    final res = await rootBundle.loadString(
        'packages/pincode_country_state_city_pro/lib/assets/country.json');
    final data = jsonDecode(res) as List;
    _cachedCountries = List<Country>.from(
      data.map((item) => Country.fromJson(item)),
    );
    return _cachedCountries;
  }

  ///get list of all countries
  static Future<List<Country>> getCountries() async {
    final countries = await _loadCountries();
    return countries;
  }

  ///Get Country from its IsoCode(alpha-2 code)
  static Future<Country?> getCountryByCode(String isoCode) async {
    final countries = await _loadCountries();
    final res =
        countries.firstWhereOrNull((country) => country.isoCode == isoCode);
    return res;
  }
}
