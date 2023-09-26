import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:flutter_hackathon/models/user_model/user.dart';
import 'package:flutter_hackathon/utils/constants.dart';

import '../../utils/screen_size_utils.dart';
import '../qr_screen/qr_screen.dart';
import '../signup_login_screens/signup_login_screen.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User? currentUser = myProvider(context: context, listen: true).currentUser;
    int points = myProvider(context: context).currentUser!.userPoints ?? 0;
    // int points = myProvider(context: context).currentUser!.userPoints ?? 0;

    return Scaffold(
      // backgroundColor: Colors.grey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.darken),
              child: Image.asset(
                "assets/images/coverProfilePic.png",
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Image.asset(
                    "assets/images/A5.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "${currentUser!.firstName} ${currentUser.lastName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: screenHeigth(context: context) * 0.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(56, 211, 240, 226),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 23,
                        child: CircleAvatar(
                          radius: 20,
                          child: const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          backgroundColor: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context: context) * 0.02,
                      ),
                      Text(
                        "You have $points points",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeigth(context: context) * 0.03,
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: screenHeigth(context: context) * 0.03,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Change Name",
                                  style: TextStyle(color: defaultColor),
                                ),
                                content: SizedBox(
                                  height: screenHeigth(context: context) * 0.2,
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: firstNameController,
                                            decoration: const InputDecoration(
                                                labelText: "First Name"),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "First Name is Required";
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFormField(
                                            controller: lastNameController,
                                            decoration: const InputDecoration(
                                                labelText: "Last Name"),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Last Name is Required";
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        if (_formKey.currentState!.validate()) {
                                          await myProvider(context: context)
                                              .editCurrentUser(
                                                  firstName:
                                                      firstNameController.text,
                                                  lastName:
                                                      lastNameController.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Name Changed')),
                                          );
                                          Navigator.of(context).pop();
                                          firstNameController.clear();
                                          lastNameController.clear();
                                        }
                                      } catch (e) {
                                        print("Error changing name $e");
                                      }
                                    },
                                    child: const Text("Ok"),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"))
                                ],
                              );
                            });
                      },
                      child: ListTile(
                        leading: Container(
                          color: const Color.fromARGB(255, 11, 82, 13),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: const Text(
                          "Change Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right_alt,
                          color: Color.fromARGB(255, 11, 82, 13),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeigth(context: context) * 0.03,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Change Email",
                                  style: TextStyle(color: defaultColor),
                                ),
                                content: SizedBox(
                                  height: screenHeigth(context: context) * 0.1,
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            labelText:
                                                AppSharedPref.getUserMail()),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Email is Required";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        if (_formKey.currentState!.validate()) {
                                          await myProvider(context: context)
                                              .editCurrentUser(
                                                  email: emailController.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Email Changed')),
                                          );
                                          Navigator.of(context).pop();
                                          firstNameController.clear();
                                          lastNameController.clear();
                                        }
                                      } catch (e) {
                                        print("Error changing Email $e");
                                      }
                                    },
                                    child: const Text("Ok"),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"))
                                ],
                              );
                            });
                      },
                      child: ListTile(
                        leading: Container(
                          color: const Color.fromARGB(255, 11, 82, 13),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: const Text(
                          "Change Email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right_alt,
                          color: Color.fromARGB(255, 11, 82, 13),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.small(
            heroTag: "ScanBtn",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const QrScreen(),
                ),
              );
            },
            child: const Icon(Icons.qr_code_scanner_outlined),
            backgroundColor: defaultColor,
          ),
          FloatingActionButton.small(
            heroTag: "LogOuBtn",
            onPressed: () {
              print("object");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute<void>(
              //     builder: (BuildContext context) => QrScreen(),
              //   ),
              // );
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentTextStyle: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                      actionsAlignment: MainAxisAlignment.center,
                      content: const Text(
                        'Are you sure you want to sign out?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            AppSharedPref.clearUserToken();
                            Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const SignupLogin()),
                              (route) => false,
                            );
                          },
                          child: const Text('Sign Out',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    );
                  });
            },
            child: const Icon(Icons.logout),
            backgroundColor: defaultColor,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
