import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/signup_login_screens/signup_login_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'provider/my_provider.dart';
import 'services/AppSharedPref.dart';
import 'shop_layout.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    super.initState();
    String? userToken = AppSharedPref.getToken();
    var myprovider = Provider.of<MyProvider>(context, listen: false);

    myprovider.getAllTools();
    myprovider.getAllPlants();
    myprovider.getAllSeeds();
    // myprovider.getAllProducts();
    print("All product length ${myprovider.allproducts.length}");

    Widget nexWidget;
    if (userToken == null) {
      nexWidget = SignupLogin();
    } else {
      nexWidget = ShopLayout();
    }
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => nexWidget)));
    // MaterialPageRoute(builder: (context) => ShopLayout())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: laVieLogo(textSize: 30)),
    );
  }
}
