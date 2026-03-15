import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

class PickerTypeToggleWidget extends StatelessWidget {
  final PickerType pickerType;
  final void Function(PickerType?) onToggle;

  const PickerTypeToggleWidget({
    super.key,
    required this.pickerType,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: PickerType.values.map((type) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<PickerType>(
              visualDensity: const VisualDensity(
                horizontal: -4,
              ),
              value: type,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              groupValue: pickerType,
              onChanged: onToggle,
            ),
            const SizedBox(width: 4),
            Text(
              type.name.capitaliseFirstLetter(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        );
      }).toList(),
    );
  }
}
