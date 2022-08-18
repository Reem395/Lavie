import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';
import '../constants.dart';
import '../services/app_shared_pref.dart';
import '../shop_layout.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String? userToken =
        Provider.of<MyProvider>(context, listen: true).accessToken;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Email",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.01,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            const Text(
              "Password",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.01,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (emailController.text == "" ||
                      passwordController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Please enter all fields",
                        toastLength: Toast.LENGTH_SHORT);
                  } else {
                    Provider.of<MyProvider>(context, listen: false).signIn(
                        email: emailController.text,
                        password: passwordController.text);

                    // String? userToken = AppSharedPref.getToken();
                    print("userToken: $userToken");
                    if (userToken == null) {
                      Fluttertoast.showToast(
                          msg: "Wrong email or password",
                          toastLength: Toast.LENGTH_SHORT);
                    } else {
                      var myprovider =
                          Provider.of<MyProvider>(context, listen: false);

                      myprovider.getAllTools();
                      myprovider.getAllPlants();
                      myprovider.getAllSeeds();

                      Fluttertoast.showToast(
                          msg: "Login Successfully",
                          toastLength: Toast.LENGTH_SHORT);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShopLayout()));
                    }
                  }
                } catch (e) {
                  print("error: $e");
                }
              },
              child: const Text("Login"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(defaultColor),
                  padding: MaterialStateProperty.all(
                      const EdgeInsetsDirectional.all(15))),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
          ],
        ),
      ),
    );
  }
}
