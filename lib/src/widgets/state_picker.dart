import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_picker_controllers.dart';
import 'package:pincode_country_state_city_pro/src/widgets/dropdown_search.dart';

class StatePicker extends StatelessWidget {
  final ValueChanged<StateModel?>? onChanged;
  final ValueChanged<StateModel?>? onSaved;
  final String Function(StateModel)? itemLabelBuilder;
  final String? Function(StateModel?)? validator;
  final AddressPickerController controller;
  const StatePicker({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.statesList,
        builder: (context, value1, _) {
          return ValueListenableBuilder(
              valueListenable: controller.selectedState,
              builder: (context, value2, _) {
                return dropDownSearch<StateModel>(
                  key: controller.stateDropdownKey,
                  context: context,
                  items: value1,
                  itemLabelBuilder: itemLabelBuilder ?? (StateModel state) => state.name,
                  onChanged: (StateModel? state) async {
                    controller.selectedState.value = state;

                    controller.selectedCity.value = null;
                    controller.pinCodeController.clear();

                    controller.cityDropdownKey.currentState?.clear();

                    if (controller.selectedCountry.value?.isoCode != null && state?.isoCode != null) {
                      controller.citiesList.value = await getCitiesOfState(
                        countryCode: controller.selectedCountry.value!.isoCode!,
                        stateCode: state!.isoCode,
                      );
                    }

                    if (onChanged != null) onChanged!(state);
                  },
                  onSaved: onSaved,
                  validator: validator,
                  selectedItem: value2,
                );
              });
        });
  }
}
