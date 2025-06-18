import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

void main() {
  AddressPickerController controller = AddressPickerController();
  runApp(MaterialApp(
    home: Scaffold(
      body: PincodeCountryStateCityPicker(
        controller: controller,
      ),
    ),
  ));
}
