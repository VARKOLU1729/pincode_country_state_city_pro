import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/typedefs.dart';

class AddressUtils {
  static AddressType getAddressTypeFromType(Type T) {
    if (T == Country) return AddressType.country;
    if (T == StateModel) return AddressType.state;
    if (T == City) return AddressType.city;
    return AddressType.pincode;
  }

  static PickerType defaultPickerType = PickerType.dropDownSearch;

  static ValidationBuilder get defaultValidationBuilder => (context, errorText) {
        if (errorText == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        );
      };
}
