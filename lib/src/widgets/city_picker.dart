import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/utils/data_utils.dart';
import 'package:pincode_country_state_city_pro/src/widgets/dropdown_search.dart';

class CityPicker extends StatelessWidget {
  final List<City> cities;
  final ValueChanged<City?> onChanged;
  final ValueChanged<City?> onSaved;
  final String Function(City)? itemLabelBuilder;
  final String? Function(City?)? validator;
  final City? selectedItem;
  Key? key;
  const CityPicker({
    .key,
    required this.cities,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.selectedItem,
    this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return dropDownSearch<City>(
      key: DataUtils.cityDropdownKey,
      context: context,
      items: cities,
      itemLabelBuilder: itemLabelBuilder ?? (city) => city.name,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      selectedItem: selectedItem,
    );
  }
}
