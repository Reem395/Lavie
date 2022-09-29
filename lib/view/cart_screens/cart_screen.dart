import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/provider/my_provider.dart';
import 'package:flutter_hackathon/models/cart_model/cart.dart';
import 'package:provider/provider.dart';

import '../../models/plants_model/plants.dart';
import '../../models/tools_model/tool.dart';
import '../../utils/constants.dart';
import '../blog_screens/single_blog_screen.dart';
import '../components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List allBlogs = myProvider(context: context).allproducts;
    // List myCart = myProvider(context: context).userCart;
    List<Map> productCountPrice;
    Widget emptyCart = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty_card.png"),
          SizedBox(
            height: screenHeigth(context: context) * 0.04,
          ),
          const Text(
            "Your Cart is Empty",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: screenHeigth(context: context) * 0.04,
          ),
          // const Text("Your Cart is Empty",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(6, 255, 255, 255),
          elevation: 0,
        ),
        body:
              Consumer<MyProvider>(builder: (context, myProvider, child) {
                 List myCart = myProvider.userCart;
                return SafeArea(
              child: myCart.isEmpty
              ? emptyCart
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        
                        itemCount: myCart.length,
                        itemBuilder: ((context, index) {
                        dynamic cartElement = ProductInCart(cartProduct: myCart[index],context: context) ;

                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              decoration: roundedContainerWithShadowBox(),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              screenHeigth(context: context) /
                                                  (926 / 14),
                                          horizontal:
                                              screenWidth(context: context) /
                                                  (428 / 11)),
                                      child: cartElement.imageUrl == ""
                                          ? Image.asset(
                                              "assets/images/plant_blog.png")
                                          : roundedImage(
                                              image: Image.network(
                                                "$baseURL${cartElement.imageUrl}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return textForImageError();
                                                },
                                                width: 146,
                                                height: 133,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "${cartElement.name}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height:
                                                screenHeigth(context: context) /
                                                    (926 / 14),
                                          ),
                                          Text(
                                            cartElement.price.toString(),
                                            style: TextStyle(
                                                color: defaultColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height:
                                                screenHeigth(context: context) /
                                                    (926 / 14),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          "-",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18,
                                                              color:
                                                                  defaultColor),
                                                        ),
                                                        onTap: () {
                                                          myProvider.decrementCartItem(
                                                            context: context,
                                                            productInstance: cartElement);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context:
                                                                    context) *
                                                            0.03,
                                                      ),
                                                      Text(
                                                    prodCount(
                                                      context: context,
                                                      productInstance: cartElement).toString()
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context:
                                                                    context) *
                                                            0.03,
                                                      ),
                                                      InkWell(
                                                        child: Text(
                                                          "+",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18,
                                                              color:
                                                                  defaultColor),
                                                        ),
                                                        onTap: () {
                                                          myProvider.incrementCartItem(
                                                            context: context,
                                                            productInstance: cartElement);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: defaultColor,
                                                ),
                                                onPressed: () {
                                                  myProvider.elementToRemove(elementToRemove: myCart[index],context: context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: screenHeigth(context: context) * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // "${myProvider(context: context).totalCartPrice} EGP",
                            "${myProvider.cartTotalPrice} EGP",
                            style: TextStyle(
                                color: defaultColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("CheckOut"),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size.infinite),
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.all(15)),
                            backgroundColor:
                                MaterialStateProperty.all(defaultColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    side: BorderSide(
                                        color: defaultColor, width: 1.5))),
                          )),
                    ),
                  ],
                ),
        );
        
              },)
        );
  
  }
}
