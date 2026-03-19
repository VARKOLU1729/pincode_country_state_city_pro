import 'package:example/picker_type_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddressPickerController controller = AddressPickerController();
  PickerType selectedPickerType = PickerType.dropDownSearch;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Pincode ➜ Country ➜ State ➜ City",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/home_page_background_image.png",
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PickerTypeToggleWidget(
                  pickerType: selectedPickerType,
                  onToggle: (type) {
                    if (type != null) {
                      setState(() {
                        selectedPickerType = type;
                        controller = AddressPickerController();
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                //Default picker
                Expanded(
                  child: PincodeCountryStateCityPicker(
                    key: ValueKey<String>(selectedPickerType.name),
                    controller: controller,
                    pickerType: selectedPickerType,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
