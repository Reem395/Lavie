import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/cart_model/cart.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:flutter_hackathon/view/cart_screens/cart_screen.dart';

import 'package:provider/provider.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';

import '../../models/products_model/products.dart';
import '../components.dart';
import '../../controller/provider/my_provider.dart';
import '../../models/plants_model/plants.dart';
import '../../models/seeds_model/seeds.dart';
import '../../models/tools_model/tool.dart';
import '../quiz_screen/quiz_screen.dart';

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
  // var screenSize;

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
    // Provider.of<MyProvider>(context,listen: false).examAvailable();
    checkToken(context);
  }

  int noProducts = 1;
  String productName = "";
  var productPrice = 70;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myProvider(context: context).examAvailable();

    return Scaffold(
      appBar: myProvider(context: context).isExamAvailable
          ? AppBar(
              backgroundColor: const Color.fromARGB(6, 255, 255, 255),
              elevation: 0,
              actions: [
                myProvider(context: context).isExamAvailable
                    ? IconButton(
                        onPressed: () {
                          DateTime now = DateTime.now();
                          DateTime date = DateTime(now.year, now.month, now.day,
                              now.hour, (now.minute) + 8);
                          print("now: ${now.minute}");
                          print("date: ${date}");
                          print("date min: ${date.minute}");
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const QuizScreen(),
                            ),
                          );
                        },
                        icon: CircleAvatar(
                            backgroundColor: defaultColor,
                            child: const Icon(
                              Icons.question_mark,
                              color: Colors.white,
                            )))
                    : const SizedBox(),
              ],
            )
          : null,
      body: Consumer<MyProvider>(
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
                      height: (screenHeigth(context: context) -
                              MediaQuery.of(context).padding.top) *
                          0.04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: searchBar(searchController: searchController),
                        ),
                        SizedBox(
                          width: screenWidth(context: context) * 0.04,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const CartScreen(),
                              ),
                            );
                          },
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
                      height: (screenHeigth(context: context) -
                              MediaQuery.of(context).padding.top) *
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
                        color: const Color.fromARGB(255, 239, 238, 238),
                        width: screenWidth(context: context) * 0.18,
                        height: screenHeigth(context: context) * 0.065,
                        borderWidth: 2.0,
                        borderColor: defaultColor,
                      ),
                    ),
                    SizedBox(
                      height: (screenHeigth(context: context) -
                              MediaQuery.of(context).padding.top) *
                          0.02,
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        selectedPage(myProvider.allproducts,
                            myProvider.cartProdCount, "productId"),
                        selectedPage(myProvider.allPlants,
                            myProvider.cartPlantCount, "plantId"),
                        selectedPage(myProvider.allSeeds,
                            myProvider.cartSeedsCount, "toolId"),
                        selectedPage(myProvider.allTools,
                            myProvider.cartToolsCount, "seedId"),
                      ]),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }

  Widget selectedPage(List category, List productCount, String productIdType) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 80,
      crossAxisSpacing: 20,
      childAspectRatio: 0.9,
      padding: EdgeInsets.only(top: screenHeigth(context: context) * 0.09),
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
                        fit: BoxFit.cover,
                      ),
                    ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          myProvider(context: context).decrementCartItem(productMap: productCount, productInstance: category[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context: context) * 0.02,
                      ),
                      Text(prodCount(
                              productCount: productCount,
                              productIdType: productIdType,
                              productInstance: category[index]).toString()),
                      SizedBox(
                        width: screenWidth(context: context) * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          myProvider(context: context).incrementCartItem(productMap: productCount, productInstance: category[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Text(
                              "+",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenHeigth(context: context) * 0.005,
                    ),
                    Text(
                      "${category[index] is Products ? category[index].price : 70} EGP",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String productId;
                        String productType;
                        if (category[index] is Plants) {
                          productId = category[index].plantId;
                          productType = "Plants";
                        } else if (category[index] is Tool) {
                          productId = category[index].toolId;
                          productType = "Tool";
                        } else if (category[index] is Products) {
                          productId = category[index].productId;
                          productType = "Products";
                        } else {
                          productId = category[index].seedId;
                          productType = "Seeds";
                        }
                        // Cart itemToCart = Cart(
                        //     productId: productId,
                        //     noProductsInCart: noProducts,
                        //     userId: userId!);
                        // myProvider(context: context).myCart.add(itemToCart);
                        // for (var item in myProvider(context: context).myCart) {
                        //   print("Item: ${item.noProductsInCart}");
                        // }

                      var noItems= prodCount(
                              productCount: productCount,
                              productIdType: productIdType,
                              productInstance: category[index]);

                        Cart toCart = Cart(userId: userId!,
                         productId: productId, noProductsInCart: noItems , productType: productType);
                         myProvider(context: context).addToCart(myCart: toCart);
                      },
                      child: const Text("Add To Cart"),
                      style: roundedButtonStyle(
                          borderRaduis: 10,
                          padding: const EdgeInsetsDirectional.all(10)),
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

  prodCount(
      {required List productCount,
       String? productIdType,
      required dynamic productInstance}) {

      String prodId;
      if (productInstance is Plants) {
        prodId = productInstance.plantId!;
      } else if (productInstance is Tool) {
        prodId = productInstance.toolId!;
      } else if (productInstance is Products) {
        prodId = productInstance.productId!;
      } else {
        prodId = productInstance.seedId;
      }
    for (Map item in productCount) {
      if (item.containsKey(prodId)) {
        print("value is: ${item.values}");
        return item.values.first;
      }
    }
  }
}
