import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:collection/collection.dart' show IterableExtension;
import 'package:pincode_country_state_city_pro/src/models/state.dart';

class StateUtils {
  static List<StateModel> _cachedStates = [];

  static Future<List<StateModel>> _loadStates() async {
    if (_cachedStates.isNotEmpty) {
      return _cachedStates;
    }
    final res = await rootBundle.loadString('packages/pincode_country_state_city_pro/lib/assets/state.json');
    final data = jsonDecode(res) as List;
    _cachedStates = List<StateModel>.from(
      data.map((item) => StateModel.fromJson(item)),
    );
    return _cachedStates;
  }

  static Future<List<StateModel>> getStates() async {
    return await _loadStates();
  }

  /// Get the list of states that belongs to a country by the country ISO CODE
  static Future<List<StateModel>> getStatesOfCountry(String countryCode) async {
    final states = await _loadStates();

    final res = states.where((stateModel) {
      return stateModel.countryCode == countryCode;
    }).toList();
    res.sort((a, b) => a.name.compareTo(b.name));

    return res;
  }

  /// Get a StateModel from its code and its belonging country code
  static Future<StateModel?> getStateByCode(
    String countryCode,
    String stateCode,
  ) async {
    final states = await _loadStates();

    final res = states.where((stateModel) {
      return stateModel.countryCode == countryCode && stateModel.isoCode == stateCode;
    }).toList();

    return res.isEmpty ? null : res.first;
  }

  static Future<StateModel?> getMatchingState({required String stateName}) async {
    final states = await _loadStates();
    StateModel? matchedState = states.firstWhereOrNull((state) => state.name == stateName);
    return matchedState;
  }
}
