import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

class DataUtils{
  static GlobalKey<DropdownSearchState<Country>> countryDropdownKey = GlobalKey();
  static GlobalKey<DropdownSearchState<StateModel>> stateDropdownKey = GlobalKey();
  static GlobalKey<DropdownSearchState<City>> cityDropdownKey = GlobalKey();
}