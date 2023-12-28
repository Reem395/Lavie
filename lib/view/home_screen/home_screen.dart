import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/cart_model/cart.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:flutter_hackathon/view/cart_screens/cart_screen.dart';

import 'package:provider/provider.dart';
import 'package:container_tab_indicator/container_tab_indicator.dart';

import '../../models/products_model/products.dart';
import '../../utils/product_utils.dart';
import '../../utils/screen_size_utils.dart';
import '../../utils/token_utils.dart';
import '../components.dart';
import '../../controller/provider/global_provider.dart';
import '../quiz_screen/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    cartProvider(context: context).getCart();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken(context);
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    examProvider(context: context).examAvailable();

    return Scaffold(
      appBar: examProvider(context: context).isExamAvailable
          ? AppBar(
              backgroundColor: const Color.fromARGB(6, 255, 255, 255),
              elevation: 0,
              actions: [
                examProvider(context: context).isExamAvailable
                    ? IconButton(
                        onPressed: () async {
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
      body: Consumer<GlobalProvider>(
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
      ),
    );
  }

  Widget selectedPage(List category) {
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
                          cartProvider(context: context).decrementCartItem(
                              productInstance: category[index],
                              context: context);
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
                      Text(cartProvider(context: context, listen: true)
                          .getCount(product: category[index], context: context)
                          .toString()),
                      SizedBox(
                        width: screenWidth(context: context) * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          cartProvider(context: context).incrementCartItem(
                              context: context,
                              productInstance: category[index]);
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
                        productId =
                            getInstanceId(productInstance: category[index]);
                        productType =
                            getInstanceType(productInstance: category[index])
                                .toString();

                        var noItems = prodCount(
                            context: context, productInstance: category[index]);

                        Cart toCart = Cart(
                            userId: userId!,
                            productId: productId,
                            noProductsInCart: noItems,
                            productType: productType);
                        cartProvider(context: context)
                            .addToCart(myCart: toCart, context: context);
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
}
