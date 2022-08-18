import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
import 'package:flutter_hackathon/models/tools_model/tools_model.dart';

import '../models/seeds_model/seeds.dart';
import '../models/seeds_model/seeds_model.dart';
import '../models/tools_model/tool.dart';
import '../models/user_model/user.dart';
import '../models/user_model/user_model.dart';
import '../services/app_shared_pref.dart';
// import 'package:flutter_hackathon/models/user/user_model.dart';

class MyProvider with ChangeNotifier {
  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  String? accessToken = AppSharedPref.getToken();
  String baseUrl = "https://lavie.orangedigitalcenteregypt.com/api/v1/";
  Future getAllSeeds() async {
    try {
      allSeeds.clear();
      var response = await Dio().get('${baseUrl}seeds',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      SeedsModel res = SeedsModel.fromJson(response.data);
      allSeeds = [...?res.data];
      allproducts.addAll(allSeeds);
      notifyListeners();
    } catch (e) {
      print("Error from get All seeds: $e");
    }
  }

   Future getAllPlants() async {
    try {
      allPlants.clear();
      var response = await Dio().get(
          '${baseUrl}plants',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      PlantsModel res = PlantsModel.fromJson(response.data);
      allPlants = [...?res.data];
      allproducts.addAll(allPlants);
      notifyListeners();
    } catch (e) {
      print("Error from get All plants: $e");
    }
  }

  Future getAllTools() async {
    try {
      allTools.clear();
      var response = await Dio().get(
          '${baseUrl}tools',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ToolsModel res = ToolsModel.fromJson(response.data);
      allTools = [...?res.data];
      allproducts.addAll(allTools);
      notifyListeners();
    } catch (e) {
      print("Error from get All Tools: $e");
    }
  }

  // void getAllProducts(){
  //   allproducts.clear();
  //   allproducts.addAll(allPlants);
  //   allproducts.addAll(allSeeds);
  //   allproducts.addAll(allTools);
  //   notifyListeners();
  // }
  void signUp(User user) async {
    try {
      Response response = await Dio().post(
          "https://lavie.orangedigitalcenteregypt.com/api/v1/auth/signup",
          data: user);

      print('User created: ${response.data}');

      var retrievedUser = User.fromJson(response.data);
      print("retrievedUser fromJson => $retrievedUser");
      notifyListeners();
    } catch (e) {
      print('Error creating user: $e');
    }
  }

   signIn({required email, required password}) async {
    try {
      Response response = await Dio().post(
          "https://lavie.orangedigitalcenteregypt.com/api/v1/auth/signin",
          data: {"email": email, "password": password});

      print('User Login : ${response.data}');

      UserModel retrievedUser = UserModel.fromJson(response.data);
      accessToken = retrievedUser.data!.accessToken;
      AppSharedPref.setToken(accessToken);
      AppSharedPref.setUserMail(email);
      print("token => ${AppSharedPref.getToken()}");
      notifyListeners();
    } catch (e) {
      print('Error Login user: $e');
    }
  }
}
