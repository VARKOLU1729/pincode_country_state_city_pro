import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/typedefs.dart';

class PickerProps<T> {
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;
  final String Function(T) itemLabelBuilder;
  final String? Function(T?)? validator;
  final AddressPickerController controller;
  final SearchWidgetType searchWidgetType;
  final AddressPickerWidgetBuilder? addressPickerWidgetBuilder;

  PickerProps({
    required this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    required this.itemLabelBuilder,
    this.searchWidgetType = SearchWidgetType.typeAheadSearch,
    this.addressPickerWidgetBuilder,
  });
}
