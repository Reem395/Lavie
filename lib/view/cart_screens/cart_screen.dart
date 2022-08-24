import 'package:flutter/material.dart';

import '../../models/plants_model/plants.dart';
import '../../models/tools_model/tool.dart';
import '../../utils/constants.dart';
import '../blog_screens/single_blog_screen.dart';
import '../components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List allBlogs = myProvider(context: context).allBlogs;

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
        body: SafeArea(
          child: myProvider(context: context).userCart.isEmpty
              ? emptyCart
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // itemCount: allBlogs.length,
                        itemCount: myProvider(context: context).userCart.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              decoration: roundedContainerWithShadowBox(),
                              child: InkWell(
                                onTap: (() {
                                  String blogId;
                                  String productType;
                                  if (allBlogs[index] is Plants) {
                                    blogId = allBlogs[index].plantId;
                                    productType = "Plants";
                                  } else if (allBlogs[index] is Tool) {
                                    blogId = allBlogs[index].toolId;
                                    productType = "Tool";
                                  } else {
                                    blogId = allBlogs[index].seedId;
                                    productType = "Seeds";
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          SingleBlogScreen(
                                        blogId: blogId,
                                        productType: productType,
                                      ),
                                    ),
                                  );
                                }),
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
                                      child: allBlogs[index].imageUrl == ""
                                          ? Image.asset(
                                              "assets/images/plant_blog.png")
                                          : roundedImage(
                                              image: Image.network(
                                                "$baseURL${allBlogs[index].imageUrl}",
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
                                            "${allBlogs[index].name}",
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
                                            "200 EGP",
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
                                                        onTap: () {},
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context:
                                                                    context) *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        "2",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        onTap: () {},
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
                            "${myProvider(context: context).totalCartPrice} EGP",
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
                                MaterialStateProperty.all(EdgeInsets.all(15)),
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
        ));
  }
}
