import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pincode_country_state_city_pro/src/models/city.dart';
import 'package:collection/collection.dart' show IterableExtension;

class CityUtils {
  static List<City> _cachedCities = [];

  static Future<List<City>> _loadCities() async {
    if (_cachedCities.isNotEmpty) {
      return _cachedCities;
    }
    final res = await rootBundle.loadString('packages/pincode_country_state_city_pro/lib/assets/city_with_postal_codes.json');
    final data = jsonDecode(res) as List;
    _cachedCities = List<City>.from(
      data.map((item) => City.fromJson(item)),
    );
    return _cachedCities;
  }

  static Future<List<City>> getCities() async {
    return await _loadCities();
  }

  /// Get the list of states that belongs to a state by the state ISO CODE and the country ISO CODE
  static Future<List<City>> getStateCities(String countryCode, String stateCode) async {
    final cities = await _loadCities();

    final res = cities.where((city) {
      return city.countryCode == countryCode && city.stateCode == stateCode;
    }).toList();
    res.sort((a, b) => a.name.compareTo(b.name));

    return res;
  }

  /// Get the list of cities that belongs to a country by the country ISO CODE
  static Future<List<City>> getCountryCities(String countryCode) async {
    final cities = await _loadCities();

    final res = cities.where((city) {
      return city.countryCode == countryCode;
    }).toList();
    res.sort((a, b) => a.name.compareTo(b.name));

    return res;
  }

  static Future<City?> getCityByCode(String cityCode) async {
    final cities = await _loadCities();
    final res = cities.where((city) => city.isoCode == cityCode).toList();
    return res.isEmpty ? null : res.first;
  }

  static Future<City?> getMatchingCity({required String cityName}) async {
    final cities = await _loadCities();
    City? matchedCity = cities.firstWhereOrNull((city) => city.name == cityName);
    return matchedCity;
  }

  static Future<City?> getCityByPostalCode({required String postalCode, required String countryCode}) async {
    final cities = await _loadCities();
    City? matchedCity = cities.firstWhereOrNull((city) => city.postalCode == postalCode && city.countryCode == countryCode);
    return matchedCity;
  }
}
