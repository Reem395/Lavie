import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/widgets/home_screen.dart';
import 'package:flutter_hackathon/widgets/notification_screen.dart';
import 'package:flutter_hackathon/widgets/quiz_screen.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../provider/my_provider.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<Widget> navPages = [
    Text("Page 1"),
    Text("Page4"),
    HomeScreen(),
    NotificationScreen(),
    Text("Page5"),
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
