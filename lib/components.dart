import 'package:flutter/material.dart';

Widget laVieLogo({Size? screenSize, double? textSize}) {
  return Stack(
    alignment: const Alignment(0.0, -0.5),
    children: [
      Text(
        "La Vie",
        style: TextStyle(
            fontFamily: 'Meddon',
            fontWeight: FontWeight.bold,
            fontSize: textSize ?? 26),
      ),
      Image.asset(
        "assets/images/plant_logo.png",
        width: screenSize == null ? 22 : screenSize.width * 0.05,
      ),
    ],
  );
}
