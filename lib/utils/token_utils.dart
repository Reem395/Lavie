import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../controller/services/app_shared_pref.dart';
import '../view/signup_login_screens/signup_login_screen.dart';

String? userToken = AppSharedPref.getToken();

void checkToken(BuildContext context) {
  if (AppSharedPref.getToken() != null) {
    // Map<String, dynamic> payload = Jwt.parseJwt(userToken!);
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
  } else {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => const SignupLogin()),
      (route) => false,
    );
  }
}

bool isTokenExpired() {
  if (userToken != null) {
    return Jwt.isExpired(userToken!);
  }
  return false;
}
