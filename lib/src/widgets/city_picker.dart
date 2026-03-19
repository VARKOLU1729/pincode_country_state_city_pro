import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/address_selection_widget.dart';
import 'package:pincode_country_state_city_pro/src/components/messenger.dart';
import 'package:pincode_country_state_city_pro/src/utils/default_props.dart';

class CityPicker extends StatelessWidget {
  final PickerProps<City> pickerProps;

  CityPicker({
    super.key,
    PickerProps<City>? pickerProps,
  }) : pickerProps = pickerProps ?? DefaultProps.cityPickerProps;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pickerProps.controller.citiesList,
      builder: (context, value1, _) {
        return ValueListenableBuilder(
          valueListenable: pickerProps.controller.selectedCity,
          builder: (context, value2, _) {
            return AddressSelectionWidget<City>(
              key: pickerProps.controller.cityDropdownKey,
              addressType: AddressType.city,
              items: value1 ?? [],
              itemLabelBuilder: pickerProps.itemLabelBuilder,
              onChanged: (City? city) {
                pickerProps.controller.selectedCity.value = city;
                pickerProps.controller.pinCodeController.clear();
                if (pickerProps.onChanged != null) pickerProps.onChanged!(city);
              },
              onSaved: pickerProps.onSaved,
              validator: pickerProps.validator,
              selectedItem: value2,
              onBeforePopupOpening: (_) async {
                if (pickerProps.controller.selectedState.value == null) {
                  showErrorSnackBar(context: context, content: "Please choose a state");
                  return false;
                }
                return true;
              },
              pickerType: pickerProps.pickerType,
              suggestionsCallBack: (String searchQuery) {
                return value1?.where((item) => item.name.toLowerCase().startsWith(searchQuery.toLowerCase())).toList();
              },
              validationBuilder: pickerProps.validationBuilder,
              showValidationError: pickerProps.showValidationError,
            );
          },
        );
      },
    );
  }
}
