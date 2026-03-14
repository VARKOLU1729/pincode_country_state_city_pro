import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/default_field_widget.dart';
import 'package:pincode_country_state_city_pro/src/models/picker_props.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/default_props.dart';

class PincodeCountryStateCityPicker extends StatefulWidget {
  PincodeCountryStateCityPicker({
    super.key,
    required this.controller,
    this.showCountryFlag = true,
    this.searchWidgetType = SearchWidgetType.dropDownSearch,
    PickerProps<Country>? countryPickerProps,
    PickerProps<StateModel>? statePickerProps,
    PickerProps<City>? cityPickerProps,
  })  : countryPickerProps = countryPickerProps ?? DefaultProps.countryPickerProps,
        statePickerProps = statePickerProps ?? DefaultProps.statePickerProps,
        cityPickerProps = cityPickerProps ?? DefaultProps.cityPickerProps;

  /// controller that manages the values of the respective picker
  final AddressPickerController controller;

  /// true if you want to show countryFlag along with its name in the UI
  final bool showCountryFlag;

  /// Whether the field is a DropDownSearch or TypeAheadSearch
  final SearchWidgetType searchWidgetType;

  final PickerProps<Country> countryPickerProps;
  final PickerProps<StateModel> statePickerProps;
  final PickerProps<City> cityPickerProps;

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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              BuildAddressWidget<Country>(
                pickerWidget: CountryPicker(
                  pickerProps: widget.countryPickerProps,
                  showCountryFlag: widget.showCountryFlag,
                ),
                pickerProps: widget.countryPickerProps,
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
                  pickerProps: DefaultProps.statePickerProps,
                ),
                pickerProps: widget.statePickerProps,
              ),
              const SizedBox(height: 20),
              BuildAddressWidget<City>(
                pickerWidget: CityPicker(
                  pickerProps: DefaultProps.cityPickerProps,
                ),
                pickerProps: widget.cityPickerProps,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildAddressWidget<T> extends StatelessWidget {
  final PickerProps<T>? pickerProps;
  final Widget pickerWidget;

  const BuildAddressWidget({super.key, this.pickerProps, required this.pickerWidget});

  @override
  Widget build(BuildContext context) {
    AddressType addressType = AddressUtils.getAddressTypeFromType(T);
    return pickerProps?.addressPickerWidgetBuilder != null
        ? pickerProps!.addressPickerWidgetBuilder!(context, pickerWidget)
        : DefaultFieldWidget(itemType: addressType, pickerWidget: pickerWidget);
  }
}
