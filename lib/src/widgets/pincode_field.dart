import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';
import 'package:pincode_country_state_city_pro/src/models/address_response.dart';
import 'package:pincode_country_state_city_pro/src/services/address_service.dart';
import 'package:pincode_country_state_city_pro/src/utils/city_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/postal_code_format_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/state_utils.dart';
import 'package:pincode_country_state_city_pro/src/utils/validator_utils.dart';

class PincodeField extends StatefulWidget {
  final AddressPickerController controller;
  const PincodeField({super.key, required this.controller});

  @override
  State<PincodeField> createState() => _PincodeFieldState();
}

class _PincodeFieldState extends State<PincodeField> {
  final FocusNode _pincodeFocusNode = FocusNode();
  bool isFetchingDataFromPincode = false;

  void handleNoCityFound() {
    if (widget.controller.selectedCity.value != null) {
      if (widget.controller.selectedCity.value!.postalCode.isNotEmpty) {
        widget.controller.selectedState.value = null;
        widget.controller.selectedCity.value = null;
        widget.controller.citiesList.value = [];
        // CommonUtils.showToast("No city found with given pinCode. Please choose the city manually");
      }
    }
  }

  Future<void> updateCSCFromIndianApi(AddressResponse addressResponse) async {
    widget.controller.selectedState.value = addressResponse.data?.state;
    widget.controller.selectedCity.value = addressResponse.data?.city;
    widget.controller.statesList.value = await StateUtils.getStatesOfCountry(widget.controller.selectedCountry.value!.isoCode!);
    if (widget.controller.selectedState.value?.isoCode != null) {
      widget.controller.citiesList.value =
          await CityUtils.getStateCities(widget.controller.selectedCountry.value!.isoCode!, widget.controller.selectedState.value!.isoCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultInputDecoration = InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Enter pincode",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        contentPadding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
        border: const OutlineInputBorder(),
        suffixIcon: isFetchingDataFromPincode
            ? const Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.orange,
                  ),
                ),
              )
            : null);

    return TextFormField(
      focusNode: _pincodeFocusNode,
      onTapOutside: (_) {
        _pincodeFocusNode.unfocus();
      },
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: "Inter"),
      decoration: defaultInputDecoration,
      // initialValue: address.pincode?.toString(),
      controller: widget.controller.pinCodeController,
      validator: (value) {
        return ValidatorUtils.validatePinCode(
          value,
          widget.controller.postalCodeFormat,
        );
      },
      onChanged: (val) async {
        val = val.trim();
        if (val.length != widget.controller.postalCodeFormat?.format?.length) return;
        setState(() {
          isFetchingDataFromPincode = true;
        });
        widget.controller.pinCodeController.text = val;
        if (val.isEmpty) {
          // clearStateCity
          widget.controller.selectedState.value = null;
          widget.controller.selectedCity.value = null;
          widget.controller.citiesList.value = [];
          return;
        }
        if (val.isNotEmpty) {
          City? city = await CityUtils.getCityByPostalCode(postalCode: val, countryCode: widget.controller.selectedCountry.value!.isoCode!);
          if (city != null) {
            // updateCSCFromCity
            widget.controller.selectedCity.value = city;
            widget.controller.selectedState.value =
                await StateUtils.getStateByCode(widget.controller.selectedCountry.value!.isoCode!, city.stateCode);
          }
          // If the generated pin code is 6 digits but doesn't match any known city (possibly due to geocoding inaccuracies),
          // then attempt to fetch the address using the Indian Postal API (free) as a fallback.
          else if (val.length == 6) {
            AddressResponse addressResponse = await AddressService.getIndianAddress(pinCode: val.toString());
            if (addressResponse.statusCode == 0) {
              await updateCSCFromIndianApi(addressResponse);
            } else {
              handleNoCityFound();
            }
          } else {
            // If the pin code is not valid or not found, reset the state and city(if they are selected and only if pincode is not empty)
            handleNoCityFound();
          }
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            isFetchingDataFromPincode = false;
          });
        });
      },
      keyboardType: PostalCodeFormatsUtils.getKeyboardTypeForPincodePattern(widget.controller.postalCodeFormat?.format),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9-\s]+$')),
        LengthLimitingTextInputFormatter(widget.controller.postalCodeFormat?.format?.length ?? 20),
      ],
    );
  }
}
