import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/address_data.dart';

class AddressResponse {
  final String? message;
  final AddressData? data;
  final int statusCode;

  AddressResponse({this.message, this.data, required this.statusCode});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      message: json['message'],
      data: json['data'] != null
          ? AddressData(
              country: json['data']['country'] != null ? Country.fromJson(json['data']['country']) : null,
              state: json['data']['state'] != null ? StateModel.fromJson(json['data']['state']) : null,
              city: json['data']['city'] != null ? City.fromJson(json['data']['city']) : null,
            )
          : null,
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
