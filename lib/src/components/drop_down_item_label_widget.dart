import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/widgets/country_flag_widget.dart';

class DropDownItemLabelWidget<T> extends StatelessWidget {
  final bool showCountryFlag;
  final AddressType addressType;
  final T item;
  final String Function(T) itemLabelBuilder;

  const DropDownItemLabelWidget({
    super.key,
    required this.showCountryFlag,
    required this.addressType,
    required this.item,
    required this.itemLabelBuilder,
  });

  bool get shouldShowCountryFlag => showCountryFlag && addressType.isCountry && (item is Country && (item as Country).flagUri != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showCountryFlag) CountryFlagWidget(flagAssetUrl: (item as Country).flagUri!),
          Expanded(
            child: Text(
              itemLabelBuilder(item),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: "Inter",
                color: Color(0xff5A6478),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
