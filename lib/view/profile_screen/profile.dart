import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  late String userName = "Mayar Mohammed";
  int points = 30;
  @override
  Widget build(BuildContext context) {
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Image.asset(
                    "assets/images/A5.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "$userName",
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
          // height: screenHeigth(context: context)*0.52,
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
                    color: Color.fromARGB(56, 211, 240, 226),
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
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right_alt,
                            color: Color.fromARGB(255, 11, 82, 13),
                            size: 30,
                          )),
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
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right_alt,
                            color: Color.fromARGB(255, 11, 82, 13),
                            size: 30,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
