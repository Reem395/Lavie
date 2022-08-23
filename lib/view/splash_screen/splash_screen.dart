import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/view/components.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/my_provider.dart';
import '../../controller/services/app_shared_pref.dart';
import '../shop_layout/shop_layout.dart';
import '../signup_login_screens/signup_login_screen.dart';

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
    print("userToken from splash: $userToken");
    var myprovider = Provider.of<MyProvider>(context, listen: false);
    print("All product length ${myprovider.allproducts.length}");
    Widget nexWidget;
    if (userToken == null) {
      nexWidget = SignupLogin();
    } else {
      myprovider.getAllTools();
      myprovider.getAllPlants();
      myprovider.getAllSeeds();
      myprovider.getAllProducts();
      myprovider.getAllForums();
      myprovider.getMyForums();
      myprovider.getBlogs();
      nexWidget = ShopLayout();
    }
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => nexWidget)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: laVieLogo(textSize: 30)),
    );
  }
}
