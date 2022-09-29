import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/cart_model/cart.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';

import '../controller/provider/my_provider.dart';
import '../controller/services/app_shared_pref.dart';
import '../models/plants_model/plants.dart';
import '../models/products_model/products.dart';
import '../models/tools_model/tool.dart';
import '../view/signup_login_screens/signup_login_screen.dart';

Color defaultColor = const Color.fromARGB(255, 30, 190, 35);
Color lightGrey = const Color.fromARGB(31, 190, 187, 187);
String baseURL = "https://lavie.orangedigitalcenteregypt.com";
String? userToken = AppSharedPref.getToken();
String? userId = AppSharedPref.getUserId();

Size screenSize({required context}) {
  return MediaQuery.of(context).size;
}

double screenHeigth({required context}) {
  return MediaQuery.of(context).size.height;
}

double screenWidth({required context}) {
  return MediaQuery.of(context).size.width;
}

MyProvider myProvider({required BuildContext context, bool listen = false}) {
  return Provider.of<MyProvider>(context, listen: listen);
}

bool isTokenExpired() {
  if (userToken != null) {
    return Jwt.isExpired(userToken!);
  }
  return false;
}

void checkToken(BuildContext context) {
  if (userToken != null) {
    Map<String, dynamic> payload = Jwt.parseJwt(userToken!);
    DateTime? expiryDate = Jwt.getExpiryDate(userToken!);
    DateTime currentDate = DateTime.now();
    Duration timeDifference = expiryDate!.difference(currentDate);
    Timer.periodic(Duration(seconds: timeDifference.inSeconds), (timer) {
      if (currentDate.compareTo(expiryDate) >= 0) {
        print("Token is expired");
        timer.cancel();
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const SignupLogin()),
          (route) => false,
        );
      }
    });
  }
}

enum ProductType {plants , tools , seeds , products}

String getInstanceId({required dynamic productInstance}){
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
    return prodId;
}

ProductType getInstanceType({required dynamic productInstance}){
 ProductType productType;
    if (productInstance is Plants) {
       productType = ProductType.plants;
    } else if (productInstance is Tool) {
       productType = ProductType.tools;
    } else if (productInstance is Products) {
       productType = ProductType.products;
    } else {
       productType = ProductType.seeds;
    }
    return productType;
}

// findProductbyID({dynamic product, required BuildContext context}){
//     dynamic foundedProduct;
//     if(myProvider(context: context).allproducts.any((element) => product.productId == element.productId)){
//         // foundedProduct = ele
//     }
// }
ProductInCart({required Cart cartProduct, required BuildContext context}){
    dynamic foundedProduct;
    // if(myProvider(context: context).allproducts.any((element) => product.productId == element.productId)){
    //     // foundedProduct = ele
    // }

  if (cartProduct.productType == ProductType.products.toString()) {
    myProvider(context: context).allproducts.forEach((item) { 
       if(item.productId == cartProduct.productId){
        foundedProduct = item;
       }
    });
  }else if (cartProduct.productType == ProductType.plants.toString()) {
    myProvider(context: context).allPlants.forEach((item) { 
       if(item.plantId == cartProduct.productId){
        foundedProduct = item;
       }
    });
  }else if (cartProduct.productType == ProductType.tools.toString()) {
    myProvider(context: context).allTools.forEach((item) { 
       if(item.toolId == cartProduct.productId){
        foundedProduct = item;
       }
    });
  }else if (cartProduct.productType == ProductType.seeds.toString()) {
    myProvider(context: context).allSeeds.forEach((item) { 
       if(item.seedId == cartProduct.productId){
        foundedProduct = item;
       }
    });
  }
    return foundedProduct;
}

List getProductMap({required dynamic productInstance, required BuildContext context}){
      List productCountMap;   
  if (getInstanceType(productInstance:productInstance) == ProductType.plants) {
      productCountMap = myProvider(context: context).cartPlantCount;
    } else if (getInstanceType(productInstance:productInstance) == ProductType.tools) {
      productCountMap = myProvider(context: context).cartToolsCount;
    } else if (getInstanceType(productInstance:productInstance) == ProductType.products) {
      productCountMap = myProvider(context: context).cartProdCount;
    } else {
      productCountMap =myProvider(context: context).cartSeedsCount;
    }
    return productCountMap;
}

  prodCount(
      {
      // String? productIdType,
      required dynamic productInstance, required BuildContext context}) {
      List productCountMap =getProductMap(productInstance: productInstance,context: context);  
    // String prodId;
    
    for (Map item in productCountMap) {
      if (item.containsKey(getInstanceId(productInstance: productInstance))) {
        print("value is: ${item.values}");
        return item.values.first;
      }
    }
  }


