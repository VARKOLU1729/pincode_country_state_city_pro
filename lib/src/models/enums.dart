enum SearchWidgetType {
  dropDownSearch,
  typeAheadSearch;

  bool get isDropDownSearch => this == SearchWidgetType.dropDownSearch;
}

enum AddressType {
  country,
  state,
  city,
  pincode;

  bool get isCountry => this == country;
}

extension StringCasingExtension on String {
  String capitaliseFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}


