import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/address_selection_widget.dart';
import 'package:pincode_country_state_city_pro/src/utils/default_props.dart';
import 'package:pincode_country_state_city_pro/src/utils/postal_code_format_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';

class CountryPicker extends StatelessWidget {
  final PickerProps<Country> pickerProps;
  final bool showCountryFlag;

  CountryPicker({
    super.key,
    PickerProps<Country>? pickerProps,
    this.showCountryFlag = true,
  }) : pickerProps = pickerProps ?? DefaultProps.countryPickerProps;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pickerProps.controller.countriesList,
      builder: (context, value1, _) {
        return ValueListenableBuilder(
          valueListenable: pickerProps.controller.selectedCountry,
          builder: (context, value2, _) {
            return AddressSelectionWidget<Country>(
              key: pickerProps.controller.countryDropdownKey,
              addressType: AddressType.country,
              items: value1 ?? [],
              itemLabelBuilder: pickerProps.itemLabelBuilder,
              showCountryFlag: showCountryFlag,
              onChanged: (Country? country) async {
                pickerProps.controller.selectedState.value = null;
                pickerProps.controller.selectedCity.value = null;
                pickerProps.controller.selectedCountry.value = country;
                pickerProps.controller.pinCodeController.clear();

                pickerProps.controller.stateDropdownKey.currentState?.clear();
                pickerProps.controller.cityDropdownKey.currentState?.clear();

                if (country?.isoCode != null) {
                  pickerProps.controller.statesList.value = await StateUtils.getStatesOfCountry(country!.isoCode!);
                  pickerProps.controller.postalCodeFormat = await PostalCodeFormatsUtils.getPostalCodeFormatByCountryCode(country.isoCode!);
                }

                if (pickerProps.onChanged != null) pickerProps.onChanged!(country);
              },
              onSaved: pickerProps.onSaved,
              validator: pickerProps.validator,
              selectedItem: value2,
              pickerType: pickerProps.pickerType,
              suggestionsCallBack: (String searchQuery) {
                final items = value1?.where((item) => item.name.toLowerCase().startsWith(searchQuery.toLowerCase())).toList();
                return items;
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
