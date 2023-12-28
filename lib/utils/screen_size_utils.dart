import 'package:flutter/material.dart';

Size screenSize({required context}) {
  return MediaQuery.of(context).size;
}

double screenHeigth({required context}) {
  return MediaQuery.of(context).size.height;
}

double screenWidth({required context}) {
  return MediaQuery.of(context).size.width;
}
