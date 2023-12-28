import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components.dart';
import '../../utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

bool hidePassword = true;
bool hideConfirmPassword = true;

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Fisrt Name",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.01,
            ),
            TextField(
              controller: firstNameController,
              decoration:
                  textFieldBorderStyle(contetPadding: const EdgeInsets.all(10)),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            const Text(
              "Last Name",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.01,
            ),
            TextField(
              controller: lastNameController,
              decoration:
                  textFieldBorderStyle(contetPadding: const EdgeInsets.all(10)),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
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
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )),
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
              controller: confirmPasswordController,
              obscureText: hideConfirmPassword,
              decoration: textFieldBorderStyle(
                  contetPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                    icon: hideConfirmPassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )),
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            userProvider(context: context).loginIndicator
                ? const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              if (firstNameController.text == "" ||
                                  lastNameController.text == "" ||
                                  emailController.text == "" ||
                                  passwordController.text == "" ||
                                  confirmPasswordController.text == "") {
                                Fluttertoast.showToast(
                                    msg: "Please enter all fields",
                                    toastLength: Toast.LENGTH_SHORT);
                              } else {
                                userProvider(context: context).signUp(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                                setState(() {
                                  userProvider(context: context)
                                      .loginIndicator = true;
                                });
                              }
                            } catch (e) {
                              print("error: $e");
                            }
                          },
                          child: const Text("Sign up"),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(defaultColor),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsetsDirectional.all(15))),
                        ),
                      ),
                    ],
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
