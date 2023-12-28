import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hackathon/models/blogs_model/blogs_model.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
import 'package:flutter_hackathon/models/products_model/product_single_model/product_single_model.dart';
import 'package:flutter_hackathon/models/tools_model/tools_model.dart';

import '../../models/products_model/products_model.dart';
import '../../models/seeds_model/seeds.dart';
import '../../models/seeds_model/seeds_model.dart';
import '../../models/tools_model/tool.dart';
import '../../utils/constants.dart';
import '../services/app_shared_pref.dart';
import 'cart_provider.dart';

class GlobalProvider with ChangeNotifier {
  CartProvider cartProvider;
  GlobalProvider(this.cartProvider);

  int selectedIndex = 2;

  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  List<dynamic> allBlogs = [];

//****************** get seed, plants, tools, products ********************************* */

  Future getAllSeeds() async {
    try {
      allSeeds.clear();
      cartProvider.cartSeedsCount.clear();
      var response = await Dio().get('$baseURL/api/v1/seeds',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      SeedsModel res = SeedsModel.fromJson(response.data);
      print("seeds : ${res.data?.length}");
      allSeeds = [...?res.data];
      for (var item in allSeeds) {
        cartProvider.cartSeedsCount.add({"${item.seedId}": 0});
      }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All seeds: $e");
    }
  }

  Future claimFreeSeed({required String address}) async {
    try {
      Response response = await Dio().post(
          "$baseURL/api/v1/user/me/claimFreeSeeds",
          data: {"address": address});
      print('Seed Claimed! : ${response.data}');
    } on DioError catch (e) {
      print('Error Login user: ${e.response!.data['message']}');
    }
  }

  Future getAllPlants() async {
    try {
      allPlants.clear();
      cartProvider.cartPlantCount.clear();
      var response = await Dio().get('$baseURL/api/v1/plants',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      PlantsModel res = PlantsModel.fromJson(response.data);
      allPlants = [...?res.data];
      for (var item in allPlants) {
        cartProvider.cartPlantCount.add({"${item.plantId}": 0});
      }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All plants: $e");
    }
  }

  Future getAllTools() async {
    try {
      allTools.clear();
      cartProvider.cartToolsCount.clear();
      var response = await Dio().get('$baseURL/api/v1/tools',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ToolsModel res = ToolsModel.fromJson(response.data);
      allTools = [...?res.data];
      for (var item in allTools) {
        cartProvider.cartToolsCount.add({"${item.toolId}": 0});
      }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All Tools: $e");
    }
  }

  Future getAllProducts() async {
    try {
      allproducts.clear();
      cartProvider.cartProdCount.clear();
      var response = await Dio().get('$baseURL/api/v1/products',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ProductsModel res = ProductsModel.fromJson(response.data);

      allproducts = [...?res.data];
      for (var item in allproducts) {
        cartProvider.cartProdCount.add({"${item.productId}": 0});
      }
      notifyListeners();
    } catch (e) {
      print("Error from get All products: $e");
    }
    notifyListeners();
  }

  Future getProductById({required String productId}) async {
    try {
      var response = await Dio().get('$baseURL/api/v1/products/$productId',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ProductSingleModel res = ProductSingleModel.fromJson(response.data);
      if (res.data != null) {
        print("single prod: ${res.data!.name}");
      } else {
        print("single product ${res.data}");
      }
      return res.data;
    } on DioError catch (e) {
      print("Error from product by ID: ${e.response!.data['message']}");
    }
  }

//****************** Blogs ********************************* */

  Future getBlogs() async {
    try {
      allBlogs.clear();
      var response = await Dio().get('$baseURL/api/v1/products/blogs',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      BlogsModel res = BlogsModel.fromJson(response.data);
      allBlogs = [
        ...?res.data!.plants,
        ...?res.data!.seeds,
        ...?res.data!.tools
      ];
      print("All Blogs length ${allBlogs.length}");
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get my forums: $e");
    }
  }
}
