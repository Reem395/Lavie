import 'package:flutter/material.dart';

import '../utils/constants.dart';

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

Widget searchBar(
    {required TextEditingController searchController, EdgeInsets? padding}) {
  return TextFormField(
    controller: searchController,
    decoration: InputDecoration(
      filled: true,
      fillColor: lightGrey,
      contentPadding: padding ?? const EdgeInsets.all(3),
      hintText: 'Search',
      prefixIcon: const Icon(Icons.search),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: lightGrey)),

      // iconColor: Colors.grey,
    ),
  );
}

InputDecoration textFieldBorderStyle(
    {EdgeInsetsGeometry? contetPadding,
    double? borderRaduis,
    Color? borderColor}) {
  return InputDecoration(
    contentPadding: contetPadding ?? EdgeInsets.all(3),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: borderColor ?? Colors.grey)),
  );
}

Widget textForImageError() {
  return const Text("Image Not Found",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}

Decoration roundedContainer({double? raduis, Color? color}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(raduis ?? 10)),
  );
}

Decoration roundedContainerWithShadowBox(
    {double? raduis,
    Color? color,
    double? spreadRadius,
    double? blurRadius,
    Offset? offset}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(raduis ?? 10)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: spreadRadius ?? 5,
        blurRadius: blurRadius ?? 7,
        offset: offset ?? const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}

Widget roundedImage({required Image image, double? raduis}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(raduis ?? 13),
    child: image,
  );
}
