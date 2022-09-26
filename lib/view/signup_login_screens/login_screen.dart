import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool hidePassword = true;

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
              decoration:
                  textFieldBorderStyle(contetPadding: const EdgeInsets.all(10)),
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
              obscureText: hidePassword,
              decoration: textFieldBorderStyle(
                  contetPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: hidePassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  )),
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
                    myProvider(context: context).signIn(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
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
