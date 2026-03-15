import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

class AddressUtils {
  static AddressType getAddressTypeFromType(Type T) {
    if (T == Country) return AddressType.country;
    if (T == StateModel) return AddressType.state;
    if (T == City) return AddressType.city;
    return AddressType.pincode;
  }

  static PickerType defaultpickerType = PickerType.dropDownSearch;
}
