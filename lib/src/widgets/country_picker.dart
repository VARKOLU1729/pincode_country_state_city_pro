import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/CustomTypeAheadField/custom_drop_down_type_ahead_search.dart';
import 'package:pincode_country_state_city_pro/src/utils/postal_code_format_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';
import 'package:pincode_country_state_city_pro/src/components/dropdown_search.dart';
import 'package:pincode_country_state_city_pro/src/widgets/country_flag_widget.dart';

class CountryPicker extends StatelessWidget {
  final ValueChanged<Country?>? onChanged;
  final ValueChanged<Country?>? onSaved;
  final String Function(Country)? itemLabelBuilder;
  final String? Function(Country?)? validator;
  final AddressPickerController controller;
  final bool showCountryFlag;
  final SearchWidgetType searchWidgetType;
  const CountryPicker({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.itemLabelBuilder,
    this.showCountryFlag = true,
    this.searchWidgetType = SearchWidgetType.dropDownSearch,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.countriesList,
      builder: (context, value1, _) {
        return ValueListenableBuilder(
          valueListenable: controller.selectedCountry,
          builder: (context, value2, _) {
            return dropDownSearch<Country>(
              key: controller.countryDropdownKey,
              dropDownItemType: DropDownItemType.country,
              context: context,
              items: value1,
              itemLabelBuilder: itemLabelBuilder ?? (Country country) => country.name,
              showCountryFlag: showCountryFlag,
              onChanged: (Country? country) async {
                controller.selectedState.value = null;
                controller.selectedCity.value = null;
                controller.selectedCountry.value = country;
                controller.pinCodeController.clear();

                controller.stateDropdownKey.currentState?.clear();
                controller.cityDropdownKey.currentState?.clear();

                if (country?.isoCode != null) {
                  controller.statesList.value = await StateUtils.getStatesOfCountry(country!.isoCode!);
                  controller.postalCodeFormat = await PostalCodeFormatsUtils.getPostalCodeFormatByCountryCode(country.isoCode!);
                }

                if (onChanged != null) onChanged!(country);
              },
              onSaved: onSaved,
              validator: validator,
              selectedItem: value2,
              searchWidgetType: searchWidgetType,
              suggestionsCallBack: (String searchQuery) {
                final items = value1.where((item) => item.name.toLowerCase().startsWith(searchQuery.toLowerCase())).toList();
                return items;
              },
            );
          },
        );
      },
    );
  }
}
