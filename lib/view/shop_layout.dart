import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/models/blogs_model/blogs.dart';
import 'package:flutter_hackathon/view/home_screen.dart';
import 'package:flutter_hackathon/view/notification_screen.dart';
import 'package:flutter_hackathon/view/profile.dart';
import 'package:flutter_hackathon/view/quiz_screen.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'blog_screens/blog_screen.dart';
import 'forums_screens/forums_screen.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<Widget> navPages = [
    Forums(),
    BlogScreen(),
    HomeScreen(),
    NotificationScreen(),
    Profile(),
  ];

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.decelerate,
          onTap: _onItemTapped,
          backgroundColor: const Color.fromARGB(44, 236, 233, 233),
          index: _selectedIndex,
          buttonBackgroundColor: const Color.fromARGB(255, 35, 212, 41),
          items: [
            Icon(
              Icons.eco_outlined,
              size: 25,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.qr_code_scanner_outlined,
              size: 25,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.home_outlined,
              size: 25,
              color: _selectedIndex == 2 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.notifications_none,
              size: 25,
              color: _selectedIndex == 3 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.person_outline,
              size: 25,
              color: _selectedIndex == 4 ? Colors.white : Colors.black,
            ),
          ]),
      body: SafeArea(
        child: navPages[_selectedIndex],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: defaultColor,
      //   child: const Icon(Icons.home_outlined),
      //   onPressed: () {},
      // ),
    );
  }
}
