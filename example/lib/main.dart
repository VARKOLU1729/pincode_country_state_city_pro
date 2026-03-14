import 'package:flutter/material.dart';
import 'package:pincode_country_state_city_pro/pincode_country_state_city_pro.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddressPickerController controller = AddressPickerController();

  @override
  void initState() {
    super.initState();
  }

  Widget toggleWidget(String text, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
        color: isSelected ? const Color.fromARGB(255, 159, 236, 165) : Colors.white,
      ),
      width: 40,
      height: 25,
      child: Center(child: Text(text)),
    );
  }

  List<bool> selectedGrid = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Pincode->Country->State->City",
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
          PincodeCountryStateCityPicker(
            controller: controller,
            searchWidgetType: SearchWidgetType.dropDownSearch,
          ),
        ],
      ),
    );
  }
}
