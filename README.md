# 📦 pincode_address_picker

A complete Flutter package to pick and validate **Country → State → City** using dropdowns or typeaheads, or auto-fill them by entering a **pincode/postal code**.

> Perfect for apps that collect addresses: e-commerce, delivery, registration, checkout, etc.

---

## ✨ Features

- ⚡  Fully offline address picker (no runtime API calls)
- 📍 Auto-detect **State and City from Pincode / Postal Code**
- 🌐 Built-in dataset of countries, states, and cities
- 🎯 RegEx-based country-specific postal code validation
- 🧩 Custom layouts using individual picker widgets
- 🔎 Supports **DropdownSearch** and **TypeAheadSearch**
- 🔧 Utility APIs if you want to build your own UI

---

## 🚀 Getting Started

### 1. Add to `pubspec.yaml`

```yaml
dependencies:
  pincode_country_state_city_pro: ^1.0
```

### 2. Quick Start

#### Using the default picker UI
```dart
final controller = AddressPickerController();

PincodeCountryStateCityPicker(
  controller: controller,
)
```

#### Custom Layout

You can build your own layouts using the individual pickers provided by the package.

```dart
//All pickers automatically stay in sync using the same controller.
final controller = AddressPickerController();

Column(
  children: [
    Row(
      children: [
        CountryPicker(
          pickerProps: PickerProps(controller: controller),
        ),
        PincodeField(controller: controller),
      ],
    ),
    Row(
      children: [
        StatePicker(),
        CityPicker(),
      ],
    ),
  ],
)
```

<table>
  <tr>
    <td>
      <img 
        src="screenshots/cscp_1.png" 
        width="300"
        height="600"
        alt="Pincode Address Picker Image"
      />
    </td>
    <td>
      <img 
        src="https://github.com/VARKOLU1729/pincode_country_state_city_pro/blob/v0.1.2/demos/dropdowns_demo.gif" 
        width="300"
        height="600"
        alt="Pincode Address Picker Demo"
      />
    </td>
  </tr>
</table>



## 🛠 AddressPickerController

#### This controller helps you manage and listen to the selected country, state, city, and pincode.

```dart
final controller = AddressPickerController();

controller.selectedCountry.addListener(() {
  print(controller.selectedCountry.value?.name);
});
```

## Get selected values

```dart
controller.selectedCountry.value;
controller.selectedState.value;
controller.selectedCity.value;
```

## 🧪 If You Want Only the Data
#### You can use the utility APIs without the picker UI.

## 🗺 Get Countries
```dart
List<Country> countries = await getAllCountries();
Country? india = await getCountryByIsoCode(isoCode: "IN");
```
## 🏙 Get States
```dart
List<StateModel> states = await getStatesOfCountry(countryCode: "IN");
StateModel? state = await getStateByCode(countryCode: "IN", stateCode: "TG");
```

## 🏡 Get Cities
```dart
List<City> cities = await getCitiesOfState(countryCode: "IN", stateCode: "AP");
City? city = await getCityByPostalCode(postalCode: "502103", countryCode: "TG");
```

### 🗺 🏙 🏡  Get Address(State, City) from postalCode
```dart
AddressData addressData = await getStateAndCityByPostalCode(postalCode: "502103", countryCode: "IN");
State state = addressData.state;
City city = addressData.city;
```

### Get PostalCodeFormat from countryCode
```dart
PostalCodeFormat? postalCodeFormat = getPostalFormatFromCountryCode(countryCode : "IN");
```
<a href="https://github.com/VARKOLU1729/pincode_country_state_city_pro/blob/main/lib/src/pincode_country_state_city_data.dart">
  For more APIs, check this file
</a>

## Additional information

🙌 Contributing : 
Found a bug? Want to add more data or improve UX?
PRs are welcome!!  Open issues, contribute, or star the repo 💙
