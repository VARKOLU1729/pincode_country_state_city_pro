import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_picker_controllers.dart';

class PincodeCountryStateCityPicker extends StatefulWidget {
  final AddressPickerController controller;
  const PincodeCountryStateCityPicker({
    super.key,
    required this.controller,
  });

  @override
  State<PincodeCountryStateCityPicker> createState() => _PincodeCountryStateCityPickerState();
}

class _PincodeCountryStateCityPickerState extends State<PincodeCountryStateCityPicker> {
  @override
  void initState() {
    super.initState();
    // Initialize the countries list
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.controller.countriesList.value = await getAllCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(height: 100),
            CountryPicker(controller: widget.controller),
            StatePicker(controller: widget.controller),
            CityPicker(controller: widget.controller),
          ],
        );
      },
    );
    ;
  }
}
