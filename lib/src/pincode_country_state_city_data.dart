import 'package:pincode_country_state_city_pro/src/models/city.dart';
import 'package:pincode_country_state_city_pro/src/models/country.dart';
import 'package:pincode_country_state_city_pro/src/models/state.dart';
import 'package:pincode_country_state_city_pro/src/utils/city_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/country_utils.dart';

//COUNTRY APIS

Future<List<Country>> getAllCountries() {
  return CountryUtils.getCountries();
}

///Get Country from its IsoCode(alpha-2 code)
Future<Country?> getCountryByIsoCode({required String isoCode}) {
  return CountryUtils.getCountryByCode(isoCode);
}

//STATE APIS

Future<List<StateModel>> getAllStates() {
  return StateUtils.getStates();
}

Future<List<StateModel>> getStatesOfCountry({required String countryCode}) {
  return StateUtils.getStatesOfCountry(countryCode);
}

Future<StateModel?> getStateByCode({required String stateCode, required String countryCode}) {
  return StateUtils.getStateByCode(countryCode, stateCode);
}

Future<StateModel?> getMatchingStateByName({required String stateName, required String countryCode}) {
  return StateUtils.getMatchingState(stateName: stateName);
}

//CITY APIS

Future<List<City>> getAllCities() {
  return CityUtils.getCities();
}

Future<List<City>> getCitiesOfCountry({required String countryCode}) {
  return CityUtils.getCountryCities(countryCode);
}

Future<List<City>> getCitiesOfState({required String countryCode, required String stateCode}) {
  return CityUtils.getStateCities(countryCode, stateCode);
}

Future<City?> getCityByCode({required cityCode}) {
  return CityUtils.getCityByCode(cityCode);
}

Future<City?> getMatchingCityByName({required String cityName}) {
  return CityUtils.getMatchingCity(cityName: cityName);
}

Future<City?> getCityByPostalCode({required String postalCode, required String countryCode}) {
  return CityUtils.getCityByPostalCode(postalCode: postalCode, countryCode: countryCode);
}
