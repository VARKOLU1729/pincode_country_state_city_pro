import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/address_drop_down_search.dart';
import 'package:pincode_country_state_city_pro/src/components/address_type_ahead_search.dart';
import 'package:pincode_country_state_city_pro/src/models/typedefs.dart';

class AddressSelectionWidget<T> extends StatelessWidget {
  const AddressSelectionWidget({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.selectedItem,
    required this.addressType,
    required this.pickerType,
    required this.suggestionsCallBack,
    required this.validationBuilder,
    this.showValidationError = true,
    this.showCountryFlag = false,
    this.onBeforePopupOpening,
    this.fieldBuilder,
  });

  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;
  final String? Function(T?)? validator;
  final T? selectedItem;
  final AddressType addressType;
  final bool showCountryFlag;
  final Future<bool?> Function(T?)? onBeforePopupOpening;
  final SuggestionsCallback<T> suggestionsCallBack;
  final PickerType pickerType;
  final Widget Function(BuildContext)? fieldBuilder;
  final bool showValidationError;
  final ValidationBuilder validationBuilder;

  @override
  Widget build(BuildContext context) {
    return pickerType.isDropDownSearch
        ? AddressDropDownSearch(
            items: items,
            itemLabelBuilder: itemLabelBuilder,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            selectedItem: selectedItem,
            addressType: addressType,
            suggestionsCallBack: suggestionsCallBack,
            fieldBuilder: fieldBuilder,
            validationBuilder: validationBuilder,
            showValidationError: showValidationError,
          )
        : AddressTypeAheadSearch(
            itemLabelBuilder: itemLabelBuilder,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            selectedItem: selectedItem,
            addressType: addressType,
            suggestionsCallBack: suggestionsCallBack,
            items: items,
            fieldBuilder: fieldBuilder,
            showValidationError: showValidationError,
            validationBuilder: validationBuilder,
          );
  }
}
