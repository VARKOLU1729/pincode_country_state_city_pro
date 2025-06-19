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

  Widget getWidget(String title, Widget mainWidget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        mainWidget,
        const SizedBox(height: 12,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              getWidget("Country", CountryPicker(controller: widget.controller)),
              getWidget("Pincode", PincodeField(controller: widget.controller)),
              getWidget("State", StatePicker(controller: widget.controller)),
              getWidget("City", CityPicker(controller: widget.controller)),
            ],
          ),
        );
      },
    );
    ;
  }
}
