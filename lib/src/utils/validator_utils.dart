import 'package:pincode_country_state_city_pro/src/models/postal_code_format.dart';

class ValidatorUtils {
  static String? validatePinCode(String? pincode, PostalCodeFormat? postalCodeFormat) {
    if (pincode == null || pincode.trim().isEmpty) {
      return "pincode can't be empty";
    }

    pincode = pincode.trim();

    if (pincode.length > 50) {
      return "PinCode exceeds 50 digits";
    }

    if (postalCodeFormat?.format?.length != null && postalCodeFormat?.format?.length != pincode.length) {
      return "Please enter pincode of size ${postalCodeFormat?.format?.length}";
    }

    if (postalCodeFormat?.regexPattern?.hasMatch(pincode) == false) {
      return "Please enter a valid pincode of type ${postalCodeFormat?.format}";
    }

    return null;
  }
}
