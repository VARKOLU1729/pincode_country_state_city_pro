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
    final res = await rootBundle.loadString('assets/CSC/state.json');
    final data = jsonDecode(res) as List;
    _cachedCountries = List<Country>.from(
      data.map((item) => Country.fromJson(item)),
    );
    return _cachedCountries;
  }

  ///get list of all countries
  static Future<List<Country>> getCountries() async {
    final _countries = await _loadCountries();
    return _countries;
  }

  ///Get Country from its IsoCode(alpha-2 code)
  static Future<Country?> getCountryByCode(String isoCode) async {
    final _countries = await _loadCountries();
    final res = _countries.firstWhereOrNull((country) => country.isoCode == isoCode);
    return res;
  }
}
