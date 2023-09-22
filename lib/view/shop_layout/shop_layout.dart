// @dart=2.12
// dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:flutter_hackathon/view/home_screen/home_screen.dart';
import 'package:flutter_hackathon/view/notification_screen/notification_screen.dart';
import 'package:flutter_hackathon/view/profile_screen/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../blog_screens/blog_screen.dart';
import '../forums_screens/forums_screen.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<Widget> navPages = [
    const Forums(),
    const BlogScreen(),
    const HomeScreen(),
    const NotificationScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      myProvider(context: context).selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = myProvider(context: context).selectedIndex;
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
              Icons.mobile_friendly,
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
    );
  }
}
