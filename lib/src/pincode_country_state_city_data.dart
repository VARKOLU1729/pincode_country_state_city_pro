import 'package:flutter/cupertino.dart';
import 'package:pincode_country_state_city_pro/src/models/address_data.dart';
import 'package:pincode_country_state_city_pro/src/models/city.dart';
import 'package:pincode_country_state_city_pro/src/models/country.dart';
import 'package:pincode_country_state_city_pro/src/models/postal_code_format.dart';
import 'package:pincode_country_state_city_pro/src/models/state.dart';
import 'package:pincode_country_state_city_pro/src/utils/city_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/postal_code_format_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/country_utils.dart';

//------COUNTRY APIS------

///Get the list of all the countries in the world
Future<List<Country>> getAllCountries() {
  return CountryUtils.getCountries();
}

///Get Country from its IsoCode(alpha-2 code)
Future<Country?> getCountryByIsoCode({required String isoCode}) {
  return CountryUtils.getCountryByCode(isoCode);
}

//------STATE APIS------

///Get the list of all States in the world
Future<List<StateModel>> getAllStates() {
  return StateUtils.getStates();
}

///Get the list of States of a [Country]
Future<List<StateModel>> getStatesOfCountry({required String countryCode}) {
  return StateUtils.getStatesOfCountry(countryCode);
}

///Get state from its isoCode
Future<StateModel?> getStateByCode(
    {required String stateCode, required String countryCode}) {
  return StateUtils.getStateByCode(countryCode, stateCode);
}

///Get Matching State by Name
Future<StateModel?> getMatchingStateByName(
    {required String stateName, required String countryCode}) {
  return StateUtils.getMatchingState(stateName: stateName);
}

//------CITY APIS------

///Get the list of all cities of the world
Future<List<City>> getAllCities() {
  return CityUtils.getCities();
}

///Get the list of cities of a country
Future<List<City>> getCitiesOfCountry({required String countryCode}) {
  return CityUtils.getCountryCities(countryCode);
}

///Get the list of cities of a state
Future<List<City>> getCitiesOfState(
    {required String countryCode, required String stateCode}) {
  return CityUtils.getStateCities(countryCode, stateCode);
}

///Get state from its isoCode
Future<City?> getCityByCode({required cityCode}) {
  return CityUtils.getCityByCode(cityCode);
}

///Get Matching City by Name
Future<City?> getMatchingCityByName({required String cityName}) {
  return CityUtils.getMatchingCity(cityName: cityName);
}

//------POSTAL CODE APIS------

///Get State and City from postalCode and CountryCode(alpha-2 code)
Future<AddressData?> getStateAndCityByPostalCode(
    {required String postalCode, required String countryCode}) async {
  City? city = await CityUtils.getCityByPostalCode(
      postalCode: postalCode, countryCode: countryCode);
  StateModel? state;
  if (city != null) {
    state = await getStateByCode(
        stateCode: city.stateCode, countryCode: countryCode);
  }
  return AddressData(state: state, city: city);
}

//------POSTAL CODE FORMAT APIS------

Future<PostalCodeFormat?> getPostalFormatFromCountryCode(
    {required String countryCode}) {
  return PostalCodeFormatsUtils.getPostalCodeFormatByCountryCode(countryCode);
}

TextInputType getKeyboardTypeForPincodeFormat(
    {required PostalCodeFormat postalCodeFormat}) {
  return PostalCodeFormatsUtils.getKeyboardTypeForPincodePattern(
      postalCodeFormat.format);
}
