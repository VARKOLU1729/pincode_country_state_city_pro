import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/postal_code_format.dart';
import 'package:pincode_country_state_city_pro/src/utils/custom_notifier.dart';

class AddressPickerController {
  AddressPickerController._privateConstructor();

  static final AddressPickerController _instance = AddressPickerController._privateConstructor();

  factory AddressPickerController() => _instance;

  GlobalKey<DropdownSearchState<Country>> countryDropdownKey = GlobalKey();
  GlobalKey<DropdownSearchState<StateModel>> stateDropdownKey = GlobalKey();
  GlobalKey<DropdownSearchState<City>> cityDropdownKey = GlobalKey();
  TextEditingController pinCodeController = TextEditingController();
  PostalCodeFormat? postalCodeFormat;

  AlwaysNotifyNotifier<List<City>> citiesList = AlwaysNotifyNotifier(<City>[]);
  AlwaysNotifyNotifier<List<StateModel>> statesList = AlwaysNotifyNotifier(<StateModel>[]);
  AlwaysNotifyNotifier<List<Country>> countriesList = AlwaysNotifyNotifier(<Country>[]);

  AlwaysNotifyNotifier<City?> selectedCity = AlwaysNotifyNotifier(null);
  AlwaysNotifyNotifier<StateModel?> selectedState = AlwaysNotifyNotifier(null);
  AlwaysNotifyNotifier<Country?> selectedCountry = AlwaysNotifyNotifier(null);
}
