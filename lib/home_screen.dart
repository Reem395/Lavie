import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/constants.dart';

import 'package:provider/provider.dart';
import 'package:flutter_hackathon/provider/my_provider.dart';

import 'models/plants_model/plants.dart';
import 'models/seeds_model/seeds.dart';
import 'models/tools_model/tool.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> allproducts = [];
  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  var screenSize;
  @override
  void initState() {
    super.initState();
    allproducts = Provider.of<MyProvider>(context, listen: false).allproducts;
    allTools = Provider.of<MyProvider>(context, listen: false).allTools;
    allSeeds = Provider.of<MyProvider>(context, listen: false).allSeeds;
    allPlants = Provider.of<MyProvider>(context, listen: false).allPlants;
    print(
        "All product length from provider ${Provider.of<MyProvider>(context, listen: false).allproducts.length}");
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int noProducts = 1;
  String productName = "";
  var productPrice = 70;
  String baseURL = "https://lavie.orangedigitalcenteregypt.com";

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    Widget allProductsPage = Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 80,
        crossAxisSpacing: 20,
        childAspectRatio: 0.9,
        padding: const EdgeInsets.only(top: 80),
        children: List.generate(allproducts.length, (index) {
          return Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 6,
                            spreadRadius: 1
                            // offset: Offset(1, 3), // changes position of shadow
                            ),
                      ]),
                ),
                // if(myprovider.allproducts[index].imageUrl!="")
                allproducts[index].imageUrl == ""
                    ? Positioned(
                        bottom: 100,
                        child: Image.asset("assets/images/p1.png"),
                      )
                    : Positioned(
                        bottom: 100,
                        child: Image.network(
                          "$baseURL${allproducts[index].imageUrl}",
                          width: 82,
                          height: 164,
                        ),
                      ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 28,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        Text("$noProducts"),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 28,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: const Text(
                              "+",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 27),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${allproducts[index].name}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.005,
                      ),
                      Text(
                        "$productPrice EGP",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Add To Cart"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(defaultColor),
                            padding: MaterialStateProperty.all(
                                const EdgeInsetsDirectional.all(10))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );

    // List<Widget> navCategories = [
    //   selectedPage(allproducts),
    //   selectedPage(allPlants),
    //   selectedPage(allSeeds),
    //   selectedPage(allTools),
    // ];
    // return Expanded(
    //   child: GridView.count(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 80,
    //     crossAxisSpacing: 20,
    //     childAspectRatio: 0.9,
    //     padding: const EdgeInsets.only(top: 80),
    //     children: List.generate(
    //         allproducts.length,
    //         (index) {
    //       return Center(
    //         child: Stack(
    //           clipBehavior: Clip.none,
    //           children: [
    //             Container(
    //               // margin: const EdgeInsets.only(top: 50),
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: const BorderRadius.all(
    //                     Radius.circular(10),
    //                   ),
    //                   boxShadow: [
    //                     BoxShadow(
    //                         color: Colors.grey.withOpacity(0.5),
    //                         blurRadius: 6,
    //                         spreadRadius: 1
    //                         // offset: Offset(1, 3), // changes position of shadow
    //                         ),
    //                   ]),
    //             ),
    //             // if(myprovider.allproducts[index].imageUrl!="")
    //             allproducts[index].imageUrl == ""
    //                 ? Positioned(
    //                     bottom: 100,
    //                     child: Image.asset("assets/images/p1.png"),
    //                   )
    //                 : Positioned(
    //                     bottom: 100,
    //                     child: Image.network(
    //                       "$baseURL${allproducts[index].imageUrl}",
    //                       width: 82,
    //                       height: 164,
    //                     ),
    //                   ),
    //             Align(
    //               alignment: Alignment.topRight,
    //               child: Padding(
    //                 padding: const EdgeInsets.only(top: 25, right: 15),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     InkWell(
    //                       onTap: () {},
    //                       child: Container(
    //                         height: 28,
    //                         width: 25,
    //                         decoration: BoxDecoration(
    //                             color: Colors.grey[200],
    //                             borderRadius: const BorderRadius.all(
    //                               Radius.circular(5),
    //                             )),
    //                         child: const Align(
    //                           alignment: Alignment.center,
    //                           child: Text(
    //                             "-",
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 fontSize: 27, fontWeight: FontWeight.bold),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: screenSize.width * 0.02,
    //                     ),
    //                     Text("$noProducts"),
    //                     SizedBox(
    //                       width: screenSize.width * 0.02,
    //                     ),
    //                     InkWell(
    //                       onTap: () {},
    //                       child: Container(
    //                         height: 28,
    //                         width: 25,
    //                         decoration: BoxDecoration(
    //                             color: Colors.grey[200],
    //                             borderRadius: const BorderRadius.all(
    //                               Radius.circular(5),
    //                             )),
    //                         child: const Text(
    //                           "+",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(fontSize: 27),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //                   Text(
    //                     "${allproducts[index].name}",
    //                     style: const TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height * 0.005,
    //                   ),
    //                   Text(
    //                     "$productPrice EGP",
    //                     style: const TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                   ElevatedButton(
    //                     onPressed: () {},
    //                     child: const Text("Add To Cart"),
    //                     style: ButtonStyle(
    //                         shape: MaterialStateProperty.all<
    //                             RoundedRectangleBorder>(RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(10.0),
    //                         )),
    //                         backgroundColor:
    //                             MaterialStateProperty.all(defaultColor),
    //                         padding: MaterialStateProperty.all(
    //                             const EdgeInsetsDirectional.all(10))),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //     }),
    //   ),
    // );
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    "All",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Tab(
                    child: Text("Plants",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17))),
                Tab(
                  child: Text(
                    "Seeds",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    "Tools",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ]),
          // SizedBox(
          //   height:
          //       (screenSize.height - MediaQuery.of(context).padding.top) * 0.05,
          // ),
          Expanded(
            child: TabBarView(children: [
              selectedPage(allproducts),
              selectedPage(allPlants),
              selectedPage(allSeeds),
              selectedPage(allTools),
            ]),
          ),
        ],
      ),
    );

    // navCategories[_selectedIndex];
  }

  Widget selectedPage(List category) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 80,
        crossAxisSpacing: 20,
        childAspectRatio: 0.9,
        padding: const EdgeInsets.only(top: 80),
        children: List.generate(category.length, (index) {
          return Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 6,
                            spreadRadius: 1
                            // offset: Offset(1, 3), // changes position of shadow
                            ),
                      ]),
                ),
                // if(myprovider.allproducts[index].imageUrl!="")
                category[index].imageUrl == ""
                    ? Positioned(
                        bottom: 100,
                        child: Image.asset("assets/images/p1.png"),
                      )
                    : Positioned(
                        bottom: 100,
                        child: Image.network(
                          "$baseURL${category[index].imageUrl}",
                          width: 82,
                          height: 164,
                        ),
                      ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 28,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        Text("$noProducts"),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 28,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                )),
                            child: const Text(
                              "+",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 27),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${category[index].name}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.005,
                      ),
                      Text(
                        "$productPrice EGP",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Add To Cart"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(defaultColor),
                            padding: MaterialStateProperty.all(
                                const EdgeInsetsDirectional.all(10))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
