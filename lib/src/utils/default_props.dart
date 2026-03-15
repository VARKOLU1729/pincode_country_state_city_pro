import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

class DefaultProps {
  static AddressPickerController addressPickerController = AddressPickerController();

  static PickerProps<Country> get countryPickerProps => PickerProps(
        controller: addressPickerController,
        itemLabelBuilder: (Country country) => country.name,
      );

  static PickerProps<StateModel> get statePickerProps => PickerProps(
        controller: addressPickerController,
        itemLabelBuilder: (StateModel state) => state.name,
      );

  static PickerProps<City> get cityPickerProps => PickerProps(
        controller: addressPickerController,
        itemLabelBuilder: (City city) => city.name,
      );
}
