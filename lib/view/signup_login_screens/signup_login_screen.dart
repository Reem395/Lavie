import 'package:flutter/material.dart';

import '../components.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/top_corner.png",
                    fit: BoxFit.fill,
                    width: screenSize.width * 0.2,
                    height:
                        (screenSize.height - MediaQuery.of(context).padding.top) *
                            0.15,
                  ),
                ),
                laVieLogo(screenSize: screenSize),
                SizedBox(
                  height:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.05,
                ),
                const TabBar(
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Tab(
                          child: Text("Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17))),
                    ]),
                SizedBox(
                  height:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.05,
                ),
                SizedBox(
                  height: screenSize.height * 0.4,
                  child: const TabBarView(
                    children: [
                      SignupScreen(),
                      LoginScreen(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                      thickness: 2,
                    )),
                    Text(
                      " or continue with ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 2,
                    )),
                  ]),
                ),
                SizedBox(
                  height:
                      (screenSize.height - MediaQuery.of(context).padding.top) *
                          0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/GoogleIcon.png'),
                      backgroundColor: Colors.white,
                      radius: 15,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/fb_icon.png'),
                      backgroundColor: Colors.white,
                      radius: 15,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    "assets/images/left_corner.png",
                    // width: screenSize.width * 0.3,
                    fit: BoxFit.fill,
                    height:
                        (screenSize.height - MediaQuery.of(context).padding.top) *
                            0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
