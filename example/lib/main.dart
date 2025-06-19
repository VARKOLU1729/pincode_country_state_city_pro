import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

void main() {
  AddressPickerController controller = AddressPickerController();
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Pincode->Country->State->City",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/yeah.png",
              fit: BoxFit.cover, // or BoxFit.fill if you want exact stretch
            ),
          ),
          PincodeCountryStateCityPicker(
            controller: controller,
          ),
        ],
      ),
    ),
  ));
}
