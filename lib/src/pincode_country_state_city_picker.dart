import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_picker_controllers.dart';

enum GridType { grid2x2, grid4x1 }

class PincodeCountryStateCityPicker extends StatefulWidget {
  final AddressPickerController controller;
  final GridType gridType;
  const PincodeCountryStateCityPicker({
    super.key,
    required this.controller,
    this.gridType = GridType.grid4x1,
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
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        mainWidget,
        const SizedBox(
          height: 12,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: widget.gridType == GridType.grid4x1
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    getWidget("Country", CountryPicker(controller: widget.controller)),
                    getWidget("Pincode", PincodeField(controller: widget.controller)),
                    getWidget("State", StatePicker(controller: widget.controller)),
                    getWidget("City", CityPicker(controller: widget.controller)),
                  ],
                )
              : SizedBox(
                  // height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: getWidget("Country", CountryPicker(controller: widget.controller))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: getWidget("Pincode", PincodeField(controller: widget.controller))),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: getWidget("State", StatePicker(controller: widget.controller))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: getWidget("City", CityPicker(controller: widget.controller))),
                        ],
                      ),
                      const Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
