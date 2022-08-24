import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/products_model/products.dart';
import 'package:flutter_hackathon/utils/constants.dart';

class SingleBlogScreen extends StatelessWidget {
  const SingleBlogScreen(
      {Key? key, required this.blogId, required this.productType})
      : super(key: key);
  final String blogId;
  final String productType;
  @override
  Widget build(BuildContext context) {
    getProduct() {
      dynamic product;

      switch (productType) {
        case "Plants":
          product = myProvider(context: context)
              .allPlants
              .firstWhere((element) => element.plantId == blogId);
          break;
        case "Tool":
          product = myProvider(context: context)
              .allTools
              .firstWhere((element) => element.toolId == blogId);
          break;
        case "Seeds":
          product = myProvider(context: context)
              .allSeeds
              .firstWhere((element) => element.seedId == blogId);
          break;

        default:
      }
      return product;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getProduct().imageUrl == ""
                ? Image.asset(
                    "assets/images/single_blog_plant.png",
                    width: double.infinity,
                    height: screenHeigth(context: context) * 0.35,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "$baseURL${getProduct().imageUrl}",
                    width: double.infinity,
                    height: screenHeigth(context: context) * 0.35,
                    fit: BoxFit.cover,
                  ),
            SizedBox(
              height: screenHeigth(context: context) * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "5 Simple Tips To Treat Plants",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: defaultColor),
                      ),
                      SizedBox(width: screenWidth(context: context) * 0.02),
                      Text(
                        "${getProduct().name}",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      // ElevatedButton(onPressed: (){
                      //  dynamic e= getProduct();
                      //   print("${e.name}");
                      // }, child: Text("hi"))
                    ],
                  ),
                  SizedBox(
                    height: screenHeigth(context: context) * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: defaultColor),
                      ),
                      SizedBox(width: screenWidth(context: context) * 0.02),
                      Text(
                        "${getProduct().description}",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
