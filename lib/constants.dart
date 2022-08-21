import 'dart:ui';
import 'package:flutter/material.dart';

Color defaultColor = const Color.fromARGB(255, 30, 190, 35);
Color lightGrey = const Color.fromARGB(31, 190, 187, 187);
Size screenSize({required context}) {
  return MediaQuery.of(context).size;
}

double screenHeigth({required context}) {
  return MediaQuery.of(context).size.height;
}

double screenWidth({required context}) {
  return MediaQuery.of(context).size.width;
}
