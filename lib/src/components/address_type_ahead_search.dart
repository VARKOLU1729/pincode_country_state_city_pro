import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/components/drop_down_item_label_widget.dart';

class AddressTypeAheadSearch<T> extends StatefulWidget {
  const AddressTypeAheadSearch({
    super.key,
    required this.itemLabelBuilder,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    required this.selectedItem,
    required this.addressType,
    required this.suggestionsCallBack,
    this.showCountryFlag = false,
    this.onBeforePopupOpening,
    required this.items,
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
  final SuggestionsCallback<T> suggestionsCallBack;
  final Widget Function(BuildContext)? fieldBuilder;

  @override
  State<AddressTypeAheadSearch<T>> createState() => _AddressTypeAheadSearchState<T>();
}

class _AddressTypeAheadSearchState<T> extends State<AddressTypeAheadSearch<T>> {
  late final TextEditingController searchQueryController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    searchQueryController = TextEditingController(
      text: widget.selectedItem != null ? widget.itemLabelBuilder(widget.selectedItem as T) : '',
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant AddressTypeAheadSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    searchQueryController.text = widget.selectedItem != null ? widget.itemLabelBuilder(widget.selectedItem as T) : '';
  }

  @override
  void dispose() {
    _focusNode.dispose();
    searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropDownTypeAheadSearch<T>(
      key: widget.key,
      searchQueryController: searchQueryController,
      focusNode: _focusNode,
      suggestionsCallback: widget.suggestionsCallBack,
      textFieldBuilder: (context, controller, focusNode) {
        final value = controller.text;
        return widget.fieldBuilder != null
            ? widget.fieldBuilder!(context)
            : TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search and select ${widget.addressType.name}",
                  enabled: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
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
      suggestionsItemBuilder: (context, item) {
        return DropDownItemLabelWidget(
          showCountryFlag: widget.showCountryFlag,
          addressType: widget.addressType,
          item: item,
          itemLabelBuilder: widget.itemLabelBuilder,
        );
      },
      constraints: const BoxConstraints(maxHeight: 200, minWidth: 200),
      onSelected: (context, t) {
        widget.onChanged?.call(t);
        _focusNode.unfocus();
      },
      minQueryLength: 2,
    );
  }
}
