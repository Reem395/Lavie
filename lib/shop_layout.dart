import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/home_screen.dart';
import 'package:flutter_hackathon/provider/my_provider.dart';
import 'package:provider/provider.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<Widget> navPages = [
    HomeScreen(),
    Text("Page2"),
    Text("Page3"),
    Text("Page4"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.eco_outlined,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner_outlined,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: ""),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            laVieLogo(),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      contentPadding: const EdgeInsets.all(3),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: lightGrey)),

                      // iconColor: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.04,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: defaultColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: (screenSize.height - MediaQuery.of(context).padding.top) *
                  0.04,
            ),
            Expanded(child: navPages[_selectedIndex]),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: defaultColor,
          child: const Icon(Icons.home_outlined),
          onPressed: () {},
        ),
      ),
    );
  }
}
