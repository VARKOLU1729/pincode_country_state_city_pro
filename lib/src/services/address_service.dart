import 'dart:convert';

import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:http/http.dart' as http;
import 'package:pincode_country_state_city_pro/src/models/address_response.dart';
import 'package:pincode_country_state_city_pro/src/utils/city_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';

class AddressService {
  static const String FILE_NAME = "address_service";
  static Future<AddressResponse> getIndianAddress(
      {required String pinCode}) async {
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

            final StateModel? state =
                await StateUtils.getMatchingState(stateName: stateName);
            final City? city =
                await CityUtils.getMatchingCity(cityName: districtName);

            addressResponse = AddressResponse.fromJson({
              'statusCode': 0,
              'message': 'Address fetched successfully',
              'data': {
                if (state != null) 'state': state.toJson(),
                if (city != null) 'city': city.toJson(),
                // 'country': {'name': 'India', 'isoCode': 'IN'}
              }
            });
          } else {
            // CommonUtils.logError(FILE_NAME, "AddressService", "Invalid response or no PostOffice data found");
          }
        }
      } else {
        // CommonUtils.logError(FILE_NAME, "AddressService", "Failed fetching address of $pinCode with statusCode: ${response.statusCode}");
      }
    } catch (err) {
      // CommonUtils.logError(FILE_NAME, "AddressService", "Error Fetching address from pincode($pinCode): $err");
    }
    return addressResponse;
  }
}
