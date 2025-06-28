import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/postal_code_format.dart';

class AddressPickerController {
  AddressPickerController._privateConstructor();
  static final AddressPickerController _instance =
      AddressPickerController._privateConstructor();
  factory AddressPickerController() => _instance;

  GlobalKey<DropdownSearchState<Country>> countryDropdownKey = GlobalKey();
  GlobalKey<DropdownSearchState<StateModel>> stateDropdownKey = GlobalKey();
  GlobalKey<DropdownSearchState<City>> cityDropdownKey = GlobalKey();
  TextEditingController pinCodeController = TextEditingController();
  PostalCodeFormat? postalCodeFormat;

  ValueNotifier<List<City>> citiesList = ValueNotifier(<City>[]);
  ValueNotifier<List<StateModel>> statesList = ValueNotifier(<StateModel>[]);
  ValueNotifier<List<Country>> countriesList = ValueNotifier(<Country>[]);

  ValueNotifier<City?> selectedCity = ValueNotifier(null);
  ValueNotifier<StateModel?> selectedState = ValueNotifier(null);
  ValueNotifier<Country?> selectedCountry = ValueNotifier(null);
}
