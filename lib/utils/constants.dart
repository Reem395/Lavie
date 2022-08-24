import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';

import '../controller/provider/my_provider.dart';
import '../controller/services/app_shared_pref.dart';
import '../models/plants_model/plants.dart';
import '../models/tools_model/tool.dart';
import '../view/signup_login_screens/signup_login_screen.dart';

Color defaultColor = const Color.fromARGB(255, 30, 190, 35);
Color lightGrey = const Color.fromARGB(31, 190, 187, 187);
String baseURL = "https://lavie.orangedigitalcenteregypt.com";
String? userToken = AppSharedPref.getToken();
String? userId = AppSharedPref.getUserId();




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

bool isTokenExpired() {
  if (userToken != null) {
    return Jwt.isExpired(userToken!);
  }
  return false;
}

void checkToken(BuildContext context) {
  if (userToken != null) {
    Map<String, dynamic> payload = Jwt.parseJwt(userToken!);
    DateTime? expiryDate = Jwt.getExpiryDate(userToken!);
    DateTime currentDate = DateTime.now();
    Duration timeDifference = expiryDate!.difference(currentDate);
    Timer.periodic(Duration(seconds: timeDifference.inSeconds), (timer) {
      if (currentDate.compareTo(expiryDate) >= 0) {
        print("Token is expired");
        timer.cancel();
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const SignupLogin()),
          (route) => false,
        );
      }
    });
  }
}


