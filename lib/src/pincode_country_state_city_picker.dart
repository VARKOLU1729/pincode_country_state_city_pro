import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/default_field_widget.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_utils.dart';

class PincodeCountryStateCityPicker extends StatefulWidget {
  const PincodeCountryStateCityPicker({
    super.key,
    required this.controller,
    this.showCountryFlag = true,
    this.pickerType = PickerType.dropDownSearch,
    this.countryPickerProps,
    this.statePickerProps,
    this.cityPickerProps,
  });

  /// controller that manages the values of the respective picker
  final AddressPickerController controller;

  /// true if you want to show countryFlag along with its name in the UI
  final bool showCountryFlag;

  /// Whether the field is a DropDownSearch or TypeAheadSearch
  final PickerType pickerType;

  final PickerProps<Country>? countryPickerProps;
  final PickerProps<StateModel>? statePickerProps;
  final PickerProps<City>? cityPickerProps;

  @override
  State<PincodeCountryStateCityPicker> createState() => _PincodeCountryStateCityPickerState();
}

class _PincodeCountryStateCityPickerState extends State<PincodeCountryStateCityPicker> {
  @override
  void initState() {
    super.initState();
    AddressUtils.defaultpickerType = widget.pickerType;
    // Initialize the countries list
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.controller.countriesList.value = await getAllCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              BuildAddressWidget<Country>(
                pickerWidget: CountryPicker(
                  pickerProps: widget.countryPickerProps,
                  showCountryFlag: widget.showCountryFlag,
                ),
              ),
              const SizedBox(height: 20),
              BuildAddressWidget(
                pickerWidget: PincodeField(
                  controller: widget.controller,
                ),
              ),
              const SizedBox(height: 20),
              BuildAddressWidget<StateModel>(
                pickerWidget: StatePicker(
                  pickerProps: widget.statePickerProps,
                ),
              ),
              const SizedBox(height: 20),
              BuildAddressWidget<City>(
                pickerWidget: CityPicker(
                  pickerProps: widget.cityPickerProps,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildAddressWidget<T> extends StatelessWidget {
  final Widget pickerWidget;

  const BuildAddressWidget({super.key, required this.pickerWidget});

  @override
  Widget build(BuildContext context) {
    AddressType addressType = AddressUtils.getAddressTypeFromType(T);
    return DefaultFieldWidget(itemType: addressType, pickerWidget: pickerWidget);
  }
}
