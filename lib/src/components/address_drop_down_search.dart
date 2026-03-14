import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/drop_down_item_label_widget.dart';
import 'package:pincode_country_state_city_pro/src/widgets/country_flag_widget.dart';

class AddressDropDownSearch<T> extends StatefulWidget {
  const AddressDropDownSearch({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.selectedItem,
    required this.addressType,
    required this.searchWidgetType,
    required this.suggestionsCallBack,
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
  final SearchWidgetType searchWidgetType;
  final SuggestionsCallback<T> suggestionsCallBack;
  final Widget Function(BuildContext)? fieldBuilder;

  @override
  State<AddressDropDownSearch<T>> createState() => _AddressDropDownSearchState<T>();
}

class _AddressDropDownSearchState<T> extends State<AddressDropDownSearch<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      popupProps: PopupProps.dialog(
        onDismissed: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        showSearchBox: true,
        showSelectedItems: true,
        searchFieldProps: TextFieldProps(
          decoration: searchFieldDecoration.copyWith(hintText: "Search ${widget.addressType.name}"),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          autofocus: true,
        ),
        loadingBuilder: (_, __) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        },
        itemBuilder: (context, item, _, __) {
          return DropDownItemLabelWidget(
            showCountryFlag: widget.showCountryFlag,
            addressType: widget.addressType,
            item: item,
            itemLabelBuilder: widget.itemLabelBuilder,
          );
        },
        emptyBuilder: (context, str) {
          return Center(
            child: Text(
              "No ${widget.addressType.name} found with '$str'.",
              style: const TextStyle(fontFamily: "Inter", color: Color(0xff5A6478), fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
      items: (_, __) {
        return widget.items;
      },
      compareFn: (countryValue, savedCountry) => true,
      itemAsString: widget.itemLabelBuilder,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onBeforePopupOpening: widget.onBeforePopupOpening,
      dropdownBuilder: (context, value) {
        return widget.fieldBuilder != null
            ? widget.fieldBuilder!(context)
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.showCountryFlag && widget.addressType == AddressType.country && value is Country && value.flagUri != null)
                    CountryFlagWidget(flagAssetUrl: value.flagUri!),
                  Text(
                    value != null ? widget.itemLabelBuilder(value) : "Select ${widget.addressType.name}",
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
              );
      },
      selectedItem: widget.selectedItem,
      decoratorProps: dropDownDecoratorProps,
    );
  }
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
  decoration: InputDecoration(
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
