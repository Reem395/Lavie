import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/provider/user_provider.dart';
import 'package:flutter_hackathon/view/signup_login_screens/claim_free_seed.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/forums_provider.dart';
import '../../controller/provider/global_provider.dart';
import '../../utils/token_utils.dart';
import '../components.dart';
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

    print("userToken from splash: $userToken");
    var globalprovider = Provider.of<GlobalProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var forumProvider = Provider.of<ForumProvider>(context, listen: false);
    // var globalprovider = Provider.of<globalProvider>(context, listen: false);
    print("All product length ${globalprovider.allproducts.length}");
    Widget nexWidget;
    if (userToken == null || isTokenExpired()) {
      nexWidget = const SignupLogin();
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => nexWidget)));
    } else {
      globalprovider.getAllTools();
      globalprovider.getAllPlants();
      globalprovider.getAllSeeds();
      globalprovider.getAllProducts();
      forumProvider.getMyForums();
      globalprovider.getBlogs();
      Future.delayed(const Duration(milliseconds: 1)).then((_) async {
        await userProvider.getCurrentUser();
        nexWidget = userProvider.userAddress == null
            ? const ClaimFreeSeed()
            : const ShopLayout();
        Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => nexWidget)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: laVieLogo(textSize: 30)),
    );
  }
}
