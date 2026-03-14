import 'package:flutter/material.dart';

class CountryFlagWidget extends StatelessWidget {
  final String flagAssetUrl;
  const CountryFlagWidget({super.key, required this.flagAssetUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Image(
        image: AssetImage(flagAssetUrl),
        height: 20,
        width: 40,
      ),
    );
  }
}
