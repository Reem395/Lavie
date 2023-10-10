import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../controller/services/app_shared_pref.dart';
import '../models/cart_model/cart.dart';
import '../models/plants_model/plants.dart';
import '../models/products_model/products.dart';
import '../models/tools_model/tool.dart';
import 'constants.dart';

enum ProductType { plants, tools, seeds, products }

String getInstanceId({required dynamic productInstance}) {
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

ProductType getInstanceType({required dynamic productInstance}) {
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

productInCart({required Cart cartProduct, required BuildContext context}) {
  dynamic foundedProduct;
  if (cartProduct.productType == ProductType.products.toString()) {
    myProvider(context: context).allproducts.forEach((item) {
      if (item.productId == cartProduct.productId) {
        foundedProduct = item;
      }
    });
  } else if (cartProduct.productType == ProductType.plants.toString()) {
    myProvider(context: context).allPlants.forEach((item) {
      if (item.plantId == cartProduct.productId) {
        foundedProduct = item;
      }
    });
  } else if (cartProduct.productType == ProductType.tools.toString()) {
    myProvider(context: context).allTools.forEach((item) {
      if (item.toolId == cartProduct.productId) {
        foundedProduct = item;
      }
    });
  } else if (cartProduct.productType == ProductType.seeds.toString()) {
    myProvider(context: context).allSeeds.forEach((item) {
      if (item.seedId == cartProduct.productId) {
        foundedProduct = item;
      }
    });
  }
  return foundedProduct;
}

List getProductMap(
    {required dynamic productInstance, required BuildContext context}) {
  List productCountMap;
  if (getInstanceType(productInstance: productInstance) == ProductType.plants) {
    productCountMap = myProvider(context: context).cartPlantCount;
  } else if (getInstanceType(productInstance: productInstance) ==
      ProductType.tools) {
    productCountMap = myProvider(context: context).cartToolsCount;
  } else if (getInstanceType(productInstance: productInstance) ==
      ProductType.products) {
    productCountMap = myProvider(context: context).cartProdCount;
  } else {
    productCountMap = myProvider(context: context).cartSeedsCount;
  }
  return productCountMap;
}

prodCount({required dynamic productInstance, required BuildContext context}) {
  List productCountMap =
      getProductMap(productInstance: productInstance, context: context);

  for (Map item in productCountMap) {
    if (item.containsKey(getInstanceId(productInstance: productInstance))) {
      print("value is: ${item.values}");
      return item.values.first;
    }
  }
}

Future<bool> checkImage({required String image}) async {
  try {
    var response = await Dio().get(image);
    if (response.statusCode == 200) {
      print("valid image");
      return true;
    } else {
      print("Invalid image");
      return false;
    }
  } catch (e) {
      print("Invalid image");
    return false;
  }
}
