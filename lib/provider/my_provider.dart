import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
import 'package:flutter_hackathon/models/tools_model/tools_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/seeds_model/seeds.dart';
import '../models/seeds_model/seeds_model.dart';
import '../models/tools_model/tool.dart';
import '../models/user_model/user.dart';
import '../models/user_model/user_model.dart';
import '../services/app_shared_pref.dart';
import '../widgets/shop_layout.dart';
// import 'package:flutter_hackathon/models/user/user_model.dart';

class MyProvider with ChangeNotifier {
  int questionNo = 1;
  DateTime? currentExamDate;
  DateTime? nextExamDate;
  bool isExamAvailable= false;

  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  Map<int, int> cartProdCount = {};
  String? accessToken = AppSharedPref.getToken();
  String baseUrl = "https://lavie.orangedigitalcenteregypt.com/api/v1/";

  void currentExamAccessDate() {
    DateTime now = DateTime.now();
    currentExamDate =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    nextExamDate =
        // DateTime(now.year, now.month, now.day, (now.hour)+10, now.minute);
        DateTime(now.year, now.month, now.day, (now.hour)+1, now.minute);
        // DateTime(now.year, now.month, now.day, now.hour, (now.minute)+2);
    AppSharedPref.setNextExamDate(nextExamDate: nextExamDate!);
    isExamAvailable=false;
    notifyListeners();
  }

  void examAvailable() {
    DateTime now = DateTime.now();
    DateTime currentDate =  DateTime(now.year, now.month, now.day, now.hour, now.minute);
      print("Next exam date ${AppSharedPref.getNextExamDate()}");
      DateTime nextDate = DateTime.parse(AppSharedPref.getNextExamDate()!) ;
    // if (AppSharedPref.getNextExamDate() == current.toString()) {
    if (currentDate.compareTo(nextDate)>=0) {
      isExamAvailable=true;
    } 
  }

  void nextQuestion() {
    if (questionNo <= 10) {
      questionNo++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (questionNo > 1) {
      questionNo--;
      notifyListeners();
    }
  }

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
      // allproducts.addAll(allSeeds);
      // for (dynamic item in allproducts) {
      //   cartProdCount.addAll({item.})
      // }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All seeds: $e");
    }
  }

  Future getAllPlants() async {
    try {
      allPlants.clear();
      var response = await Dio().get('${baseUrl}plants',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      PlantsModel res = PlantsModel.fromJson(response.data);
      allPlants = [...?res.data];
      // allproducts.addAll(allPlants);
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All plants: $e");
    }
  }

  Future getAllTools() async {
    try {
      allTools.clear();
      var response = await Dio().get('${baseUrl}tools',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ToolsModel res = ToolsModel.fromJson(response.data);
      allTools = [...?res.data];
      // allproducts.addAll(allTools);
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All Tools: $e");
    }
  }

  Future getAllProducts() async {
    try {
      allproducts.clear();
      var response = await Dio().get('${baseUrl}products',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ToolsModel res = ToolsModel.fromJson(response.data);
      allproducts = [...?res.data];
      // allproducts.addAll(allTools);
      notifyListeners();
    } catch (e) {
      print("Error from get All products: $e");
    }
    notifyListeners();
  }

  Future signUp(User user) async {
    try {
      Response response = await Dio().post(
          "https://lavie.orangedigitalcenteregypt.com/api/v1/auth/signup",
          data: user);

      print('User created: ${response.data}');

      var retrievedUser = User.fromJson(response.data);
      print("retrievedUser fromJson => $retrievedUser");
      notifyListeners();
    } on DioError catch (e) {
      print('Error creating user: $e');
    }
  }

  Future signIn({required email, required password, required context}) async {
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
      if (accessToken != null) {
        getAllTools();
        getAllPlants();
        getAllSeeds();
        getAllProducts();
        notifyListeners();

        print("User token is not null: $accessToken");
        Fluttertoast.showToast(
            msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopLayout()));
      }
    } on DioError catch (e) {
      print('Error Login user: $e');
      Fluttertoast.showToast(
          msg: "Wrong email or password", toastLength: Toast.LENGTH_SHORT);
    }
  }
}
