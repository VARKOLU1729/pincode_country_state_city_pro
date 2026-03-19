import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/typedefs.dart';
import 'package:pincode_country_state_city_pro/src/utils/address_utils.dart';

class PickerProps<T> {
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;
  final String Function(T) itemLabelBuilder;
  final String? Function(T?)? validator;
  final AddressPickerController controller;
  final bool showValidationError;
  final PickerType pickerType;
  final ValidationBuilder validationBuilder;

  PickerProps({
    required this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    required this.itemLabelBuilder,
    this.showValidationError = true,
    PickerType? pickerType,
    Widget Function(BuildContext, String?)? validationBuilder,
  })  : pickerType = pickerType ?? AddressUtils.defaultPickerType,
        validationBuilder = (validationBuilder ?? AddressUtils.defaultValidationBuilder);
}
