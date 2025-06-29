import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/country_flag_widget.dart';
import 'package:pincode_country_state_city_pro/src/components/drop_down_item_type.dart';

Widget dropDownSearch<T>({
  required Key? key,
  required BuildContext context,
  required List<T> items,
  required String Function(T) itemLabelBuilder,
  required ValueChanged<T?>? onChanged,
  required ValueChanged<T?>? onSaved,
  required String? Function(T?)? validator,
  required T? selectedItem,
  required DropDownItemType dropDownItemType,
  bool showCountryFlag = false,
  Future<bool?> Function(T?)? onBeforePopupOpening,
}) {
  return DropdownSearch<T>(
    key: key,
    popupProps: PopupProps.dialog(
        onDismissed: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        showSearchBox: true,
        isFilterOnline: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: searchFieldDecoration.copyWith(hintText: "Search ${dropDownItemType.name}"),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          autofocus: true,
        ),
        itemBuilder: (context, item, b) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (showCountryFlag && dropDownItemType == DropDownItemType.country && item is Country && item.flagUri != null)
                  countryFlagWidget(item.flagUri!),
                Text(
                  itemLabelBuilder(item),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontFamily: "Inter", color: Color(0xff5A6478), fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
        emptyBuilder: (context, str) {
          return Center(
            child: Text(
              "No ${dropDownItemType.name} found with '$str'.",
              style: const TextStyle(fontFamily: "Inter", color: Color(0xff5A6478), fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        },
        favoriteItemProps: const FavoriteItemProps(showFavoriteItems: true)),
    items: items,
    compareFn: (countryValue, savedCountry) => true,
    itemAsString: itemLabelBuilder,
    onChanged: onChanged,
    onSaved: onSaved,
    validator: validator,
    onBeforePopupOpening: onBeforePopupOpening,
    dropdownBuilder: (context, value) {
      return Row(
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
              color: value != null ? Colors.black : Colors.black.withOpacity(0.75),
              fontWeight: value != null ? FontWeight.w500 : null,
            ),
          ),
        ],
      );
    },
    selectedItem: selectedItem,
    clearButtonProps: const ClearButtonProps(isVisible: false),
    dropdownDecoratorProps: dropDownDecoratorProps,
  );
}

InputDecoration searchFieldDecoration = const InputDecoration(
  filled: true,
  fillColor: Color(0xffEFF3FF),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none)),
  contentPadding: EdgeInsets.only(left: 8.0, bottom: 8.0),
  prefixIcon: Icon(Icons.search),
  prefixIconColor: Color(0xff5A6478),
  floatingLabelBehavior: FloatingLabelBehavior.never,
  // labelText: "Search countries or dial code",
  labelStyle: TextStyle(fontFamily: "Inter", color: Color(0xff828282), fontSize: 14, fontWeight: FontWeight.w400),
  hintStyle: TextStyle(fontFamily: "Inter", color: Color(0xff828282), fontSize: 14, fontWeight: FontWeight.w400),
);

DropDownDecoratorProps dropDownDecoratorProps = const DropDownDecoratorProps(
  dropdownSearchDecoration: InputDecoration(
    hoverColor: Colors.transparent,
    filled: true,
    fillColor: Color(0xffFDFBF9),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
    ),
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
  ),
);
