import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> navPages = [
    Text("Page1"),
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
    const title = 'Grid List';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 2 + 145,
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // gradient: sLinearColorBlue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        Positioned(
                          height: 555,
                          child: CircleAvatar(
                            radius: 60.0,
                            child: ClipRRect(
                              child: Image.asset('assets/account.jpg'),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
