import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/picker_props.dart';

class DefaultProps {
  static AddressPickerController addressPickerController = AddressPickerController();
  static PickerProps<Country> countryPickerProps = PickerProps(
    controller: addressPickerController,
    itemLabelBuilder: (Country country) => country.name,
  );
  static PickerProps<StateModel> statePickerProps = PickerProps(
    controller: addressPickerController,
    itemLabelBuilder: (StateModel state) => state.name,
  );
  static PickerProps<City> cityPickerProps = PickerProps(
    controller: addressPickerController,
    itemLabelBuilder: (City city) => city.name,
  );
}
