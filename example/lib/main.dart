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
  GridType gridType = GridType.grid4x1;

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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Pincode->Country->State->City",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ToggleButtons(
            isSelected: selectedGrid,
            children: [
              toggleWidget("4x1", selectedGrid[0]),
              toggleWidget("2x2", selectedGrid[1]),
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < 2; i++) {
                  selectedGrid[i] = i == index;
                }
                if (index == 0) gridType = GridType.grid4x1;
                if (index == 1) gridType = GridType.grid2x2;
              });
            },
          )
        ],
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
            gridType: gridType,
          ),
        ],
      ),
    );
  }
}
