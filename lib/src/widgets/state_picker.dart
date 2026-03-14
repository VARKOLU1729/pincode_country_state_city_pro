import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/address_selection_widget.dart';
import 'package:pincode_country_state_city_pro/src/components/messenger.dart';
import 'package:pincode_country_state_city_pro/src/models/picker_props.dart';

class StatePicker extends StatelessWidget {
  final PickerProps<StateModel> pickerProps;

  const StatePicker({
    super.key,
    required this.pickerProps,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pickerProps.controller.statesList,
      builder: (context, value1, _) {
        return ValueListenableBuilder(
          valueListenable: pickerProps.controller.selectedState,
          builder: (context, value2, _) {
            return AddressSelectionWidget<StateModel>(
              key: pickerProps.controller.stateDropdownKey,
              addressType: AddressType.state,
              items: value1,
              itemLabelBuilder: pickerProps.itemLabelBuilder,
              onChanged: (StateModel? state) async {
                pickerProps.controller.selectedState.value = state;

                pickerProps.controller.selectedCity.value = null;
                pickerProps.controller.pinCodeController.clear();

                pickerProps.controller.cityDropdownKey.currentState?.clear();

                if (pickerProps.controller.selectedCountry.value?.isoCode != null && state?.isoCode != null) {
                  pickerProps.controller.citiesList.value = await getCitiesOfState(
                    countryCode: pickerProps.controller.selectedCountry.value!.isoCode!,
                    stateCode: state!.isoCode,
                  );
                }

                if (pickerProps.onChanged != null) pickerProps.onChanged!(state);
              },
              onSaved: pickerProps.onSaved,
              validator: pickerProps.validator,
              selectedItem: value2,
              onBeforePopupOpening: (_) async {
                if (pickerProps.controller.selectedCountry.value == null) {
                  showErrorSnackBar(context: context, content: "Please choose a country");
                  return false;
                }
                return true;
              },
              searchWidgetType: pickerProps.searchWidgetType,
              suggestionsCallBack: (String searchQuery) {
                return value1.where((item) => item.name.toLowerCase().startsWith(searchQuery.toLowerCase())).toList();
              },
            );
          },
        );
      },
    );
  }
}
