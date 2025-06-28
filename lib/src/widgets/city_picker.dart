import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/messenger.dart';
import 'package:pincode_country_state_city_pro/src/widgets/dropdown_search.dart';

class CityPicker extends StatelessWidget {
  final ValueChanged<City?>? onChanged;
  final ValueChanged<City?>? onSaved;
  final String Function(City)? itemLabelBuilder;
  final String? Function(City?)? validator;
  final GlobalKey<DropdownSearchState<City>>? dropDownSearchkey;
  final AddressPickerController controller;
  const CityPicker({
    super.key,
    required this.controller,
    this.dropDownSearchkey,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.citiesList,
        builder: (context, value1, _) {
          return ValueListenableBuilder(
              valueListenable: controller.selectedCity,
              builder: (context, value2, _) {
                return dropDownSearch<City>(
                    key: controller.cityDropdownKey,
                    dropDownItemType: DropDownItemType.city,
                    context: context,
                    items: value1,
                    itemLabelBuilder:
                        itemLabelBuilder ?? (City city) => city.name,
                    onChanged: (City? city) {
                      controller.selectedCity.value = city;

                      controller.pinCodeController.clear();
                      if (onChanged != null) onChanged!(city);
                    },
                    onSaved: onSaved,
                    validator: validator,
                    selectedItem: value2,
                    onBeforePopupOpening: (_) async {
                      if (controller.selectedState.value == null) {
                        showErrorSnackBar(
                            context: context, content: "Please choose a state");
                        return false;
                      }
                      return true;
                    });
              });
        });
  }
}
