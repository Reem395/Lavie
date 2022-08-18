import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants.dart';

import 'package:provider/provider.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter_hackathon/provider/my_provider.dart';

import '../components.dart';
import '../models/plants_model/plants.dart';
import '../models/seeds_model/seeds.dart';
import '../models/tools_model/tool.dart';

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
    // allTools=List.from(Provider.of<MyProvider>(context, listen: false).allTools);
    // allSeeds = List.from(Provider.of<MyProvider>(context, listen: false).allSeeds);
    // allPlants = List.from(Provider.of<MyProvider>(context, listen: false).allPlants);
    // allproducts = List.from(Provider.of<MyProvider>(context, listen: false).allproducts);

    print(
        "All product length from provider ${Provider.of<MyProvider>(context, listen: false).allproducts.length}");
    print(
        "All allPlants length from provider ${Provider.of<MyProvider>(context, listen: false).allPlants.length}");
    print(
        "All allSeeds length from provider ${Provider.of<MyProvider>(context, listen: false).allSeeds.length}");
    print(
        "All allTools length from provider ${Provider.of<MyProvider>(context, listen: false).allTools.length}");
  }

  int noProducts = 1;
  String productName = "";
  var productPrice = 70;
  String baseURL = "https://lavie.orangedigitalcenteregypt.com";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Consumer<MyProvider>(
      builder: (context, myProvider, child) {
        return DefaultTabController(
            length: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    laVieLogo(),
                    SizedBox(
                      height:
                          (screenSize.height - MediaQuery.of(context).padding.top) *
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
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
                      height:
                          (screenSize.height - MediaQuery.of(context).padding.top) *
                              0.04,
                    ),
                    TabBar(
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(
                          child: Text(
                            "All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Tab(
                            child: Text("Plants",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                        Tab(
                          child: Text(
                            "Seeds",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Tools",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                      indicator: ContainerTabIndicator(
                        radius: const BorderRadius.all(Radius.circular(12.0)),
                        color: Color.fromARGB(255, 239, 238, 238),
                        width: screenSize.width * 0.18,
                        height: screenSize.height * 0.065,
                        borderWidth: 2.0,
                        borderColor: defaultColor,
                      ),
                    ),
                    SizedBox(
                      height: (screenSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.04,
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        // selectedPage(allproducts),
                        // selectedPage(allPlants),
                        // selectedPage(allSeeds),
                        // selectedPage(allTools),
                        selectedPage(myProvider.allproducts),
                        selectedPage(myProvider.allPlants),
                        selectedPage(myProvider.allSeeds),
                        selectedPage(myProvider.allTools),
                      ]),
                    ),
                  ]),
            ),
          );
        
      },
    );
  }

  Widget selectedPage(List category) {
    return GridView.count(
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: 1),
                    ]),
              ),
              category[index].imageUrl == ""
                  ? Positioned(
                      bottom: 100,
                      child: Image.asset(
                        "assets/images/p1.png",
                        width: 82,
                        height: 164,
                      ),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
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
    );
  }
}
