import 'package:flutter/material.dart';
import 'package:flutter_hackathon/view/shop_layout/shop_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/constants.dart';
import '../../utils/screen_size_utils.dart';
import '../components.dart';

class ClaimFreeSeed extends StatefulWidget {
  const ClaimFreeSeed({Key? key}) : super(key: key);

  @override
  State<ClaimFreeSeed> createState() => _ClaimFreeSeedState();
}

TextEditingController addressController = TextEditingController();

class _ClaimFreeSeedState extends State<ClaimFreeSeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Image.asset(
              "assets/images/free_seed.png",
              width: double.infinity,
              height: screenHeigth(context: context) * 0.28,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: screenHeigth(context: context) * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  laVieLogo(),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.02,
                  ),
                  const Text(
                    "Get Seeds For Free",
                    style: TextStyle(
                        fontFamily: "Karantina",
                        letterSpacing: 4,
                        fontSize: 45),
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.02,
                  ),
                  const Text(
                    "Enter Your Address",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.04,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: textFieldBorderStyle(
                        contetPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        hintText: "Address"),
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        try {
                          if (addressController.text == "" ||
                              addressController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter your address",
                                toastLength: Toast.LENGTH_SHORT);
                          } else {
                            myProvider(context: context)
                                .claimFreeSeed(address: addressController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShopLayout()));
                          }
                        } catch (e) {
                          print("Error claiming seeds  $e");
                        }
                      },
                      child: const Text("Send"),
                      style: roundedButtonStyle(),
                    ),
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShopLayout()));
                      },
                      child: const Text("Save For Later"),
                      style: roundedButtonStyle(
                          buttonColor: const Color.fromARGB(255, 231, 226, 226),
                          borderColor: const Color.fromARGB(255, 231, 226, 226),
                          foregroundColor: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
