import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/enums.dart';

class DefaultFieldWidget extends StatelessWidget {
  final AddressType itemType;
  final Widget pickerWidget;

  const DefaultFieldWidget({super.key, required this.itemType, required this.pickerWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemType.name.capitaliseFirstLetter(),
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        pickerWidget,
      ],
    );
  }
}
