import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/address_response.dart';
import 'package:pincode_country_state_city_pro/src/utils/city_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';

class AddressService {
  static const String fileName = "address_service";

  //Fallback service for indian postal codes -
  //if the entered postal codes doesn't match with the existing postal codes data
  static Future<AddressResponse> getIndianAddress({required String pinCode}) async {
    String url = 'https://api.postalpincode.in/pincode/$pinCode';
    AddressResponse addressResponse = AddressResponse(statusCode: -1);
    try {
      http.Response? response;
      response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty && jsonResponse[0]['Status'] == 'Success') {
          final postOffices = jsonResponse[0]['PostOffice'] as List<dynamic>;
          if (postOffices.isNotEmpty) {
            final postOffice = postOffices[0];

            final stateName = postOffice['State'];
            final districtName = postOffice['District'];

            final StateModel? state = await StateUtils.getMatchingState(stateName: stateName);
            final City? city = await CityUtils.getMatchingCity(cityName: districtName);

            addressResponse = AddressResponse.fromJson({
              'statusCode': 0,
              'message': 'Address fetched successfully',
              'data': {
                if (state != null) 'state': state.toJson(),
                if (city != null) 'city': city.toJson(),
                // 'country': {'name': 'India', 'isoCode': 'IN'}
              }
            });
          }
        }
      }
    } catch (err) {
      //error
    }
    return addressResponse;
  }
}
