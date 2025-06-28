import 'dart:ui';

import 'package:flutter/material.dart';

Widget countryFlagWidget(String flagAssetUrl) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Image(
      image: AssetImage(flagAssetUrl),
      height: 20,
      width: 40,
    ),
  );
}
