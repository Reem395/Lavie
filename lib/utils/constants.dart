import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider/my_provider.dart';

Color defaultColor = const Color.fromARGB(255, 30, 190, 35);
Color lightGrey = const Color.fromARGB(31, 190, 187, 187);
String baseURL = "https://lavie.orangedigitalcenteregypt.com";

Size screenSize({required context}) {
  return MediaQuery.of(context).size;
}

double screenHeigth({required context}) {
  return MediaQuery.of(context).size.height;
}

double screenWidth({required context}) {
  return MediaQuery.of(context).size.width;
}

MyProvider myProvider({required BuildContext context, bool? listen}) {
  return Provider.of<MyProvider>(context, listen: listen ?? false);
}
