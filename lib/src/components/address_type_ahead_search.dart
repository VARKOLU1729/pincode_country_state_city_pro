import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/CustomTypeAheadField/typeahead_types.dart';

import 'CustomTypeAheadField/custom_drop_down_type_ahead_search.dart';

class AddressTypeAheadSearch<T> extends StatefulWidget {
  const AddressTypeAheadSearch({
    super.key,
    required this.itemLabelBuilder,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.selectedItem,
    required this.dropDownItemType,
    required this.suggestionsCallBack,
    this.showCountryFlag = false,
    this.onBeforePopupOpening,
    required this.items,
  });

  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;
  final String? Function(T?)? validator;
  final T? selectedItem;
  final DropDownItemType dropDownItemType;
  final bool showCountryFlag;
  final Future<bool?> Function(T?)? onBeforePopupOpening;
  final SuggestionsCallback<T> suggestionsCallBack;

  @override
  State<AddressTypeAheadSearch<T>> createState() => _AddressTypeAheadSearchState<T>();
}

class _AddressTypeAheadSearchState<T> extends State<AddressTypeAheadSearch<T>> {
  @override
  Widget build(BuildContext context) {
    return CustomDropDownTypeAheadSearch<T>(
      key: key,
      searchQueryController: searchQueryController,
      focusNode: focusNode,
      suggestionsCallback: suggestionsCallBack,
      textFieldBuilder: (context, controller, focusNode) {
        final value = controller.text;
        return TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Search and select ${dropDownItemType.name}"),
          maxLines: 1,
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Inter",
            color: value.isNotEmpty ? Colors.black : Colors.black.withAlpha((0.75 * 255).round()),
            fontWeight: value.isNotEmpty ? FontWeight.w500 : null,
          ),
        );
      },
      suggestionsItemBuilder: (context, value) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (showCountryFlag && dropDownItemType == DropDownItemType.country && value is Country && value.flagUri != null)
                countryFlagWidget(value.flagUri!),
              Text(
                value != null ? itemLabelBuilder(value) : "Select ${dropDownItemType.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  color: value != null ? Colors.black : Colors.black.withAlpha((0.75 * 255).round()),
                  fontWeight: value != null ? FontWeight.w500 : null,
                ),
              ),
            ],
          ),
        );
      },
      constraints: const BoxConstraints(maxHeight: 200, minWidth: 200),
      onSelected: (context, t) {
        onChanged?.call(t);
        focusNode.unfocus();
      },
    );
  }
}
