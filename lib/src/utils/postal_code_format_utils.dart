import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pincode_country_state_city_pro/src/models/postal_code_format.dart';

class PostalCodeFormatsUtils {
  static List<PostalCodeFormat> _cachedPostalCodeFormats = [];

  static Future<List<PostalCodeFormat>> _loadPostalCodeFormats() async {
    if (_cachedPostalCodeFormats.isNotEmpty) {
      return _cachedPostalCodeFormats;
    }
    final res = await rootBundle.loadString(
        'packages/pincode_country_state_city_pro/lib/assets/postal_code_formats.json');
    final data = jsonDecode(res) as List;
    _cachedPostalCodeFormats = List<PostalCodeFormat>.from(
      data.map((item) => PostalCodeFormat(
            countryCode: item['ISO'],
            format: item['Zip Format'] == "" ? null : item['Zip Format'],
            regexPattern: (item["Regex"] == "") ? null : RegExp(item['Regex']),
          )),
    );
    return _cachedPostalCodeFormats;
  }

  static Future<PostalCodeFormat?> getPostalCodeFormatByCountryCode(
      String countryCode) async {
    final formats = await _loadPostalCodeFormats();
    final res =
        formats.firstWhere((format) => format.countryCode == countryCode);
    return res;
  }

  static TextInputType getKeyboardTypeForPincodePattern(String? zipFormat) {
    if (zipFormat == null) return TextInputType.text;
    final allowedRegEx = RegExp(r'^[\d\s-]+$'); //number keyboard regex
    if (allowedRegEx.hasMatch(zipFormat)) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }
}
