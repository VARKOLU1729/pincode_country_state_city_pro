import 'package:flutter/cupertino.dart';

///context, picker[CountryPicker, StatePicker, CityPicker]
typedef AddressPickerWidgetBuilder = Widget Function(BuildContext, Widget);

//context, errorText
typedef ValidationBuilder = Widget Function(BuildContext, String?);
