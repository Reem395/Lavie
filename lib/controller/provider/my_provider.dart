import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hackathon/models/blogs_model/blogs_model.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
import 'package:flutter_hackathon/models/tools_model/tools_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/forum_model/forum.dart';
import '../../models/forum_model/forum_model.dart';
import '../../models/products_model/products.dart';
import '../../models/products_model/products_model.dart';
import '../../models/seeds_model/seeds.dart';
import '../../models/seeds_model/seeds_model.dart';
import '../../models/tools_model/tool.dart';
import '../../models/user_model/user.dart';
import '../../models/user_model/user_model.dart';
import '../../utils/constants.dart';
import '../../view/shop_layout/shop_layout.dart';
import '../services/app_shared_pref.dart';

class MyProvider with ChangeNotifier {
  int questionNo = 1;
  DateTime? currentExamDate;
  DateTime? nextExamDate;
  bool isExamAvailable = false;

  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  List<Forum> allPosts = [];
  List<Forum> myPosts = [];
  List<dynamic> allBlogs = [];
  Map<int, int> cartProdCount = {};
  String? accessToken = AppSharedPref.getToken();

  void currentExamAccessDate() {
    DateTime now = DateTime.now();
    currentExamDate =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    nextExamDate =
        DateTime(now.year, now.month, (now.day) + 10, now.hour, now.minute);
    // DateTime(now.year, now.month, now.day, now.hour, (now.minute)+30);
    AppSharedPref.setNextExamDate(nextExamDate: nextExamDate!);
    isExamAvailable = false;
    notifyListeners();
  }

  void examAvailable() {
    DateTime now = DateTime.now();
    DateTime currentDate =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    print("Next exam date ${AppSharedPref.getNextExamDate()}");
    if (AppSharedPref.getNextExamDate() != null) {
      DateTime nextDate = DateTime.parse(AppSharedPref.getNextExamDate()!);
      if (currentDate.compareTo(nextDate) >= 0) {
        isExamAvailable = true;
      }
    } else {
      isExamAvailable = true;
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
      var response = await Dio().get('$baseURL/api/v1/seeds',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      SeedsModel res = SeedsModel.fromJson(response.data);
      allSeeds = [...?res.data];
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All seeds: $e");
    }
  }

  Future getAllPlants() async {
    try {
      allPlants.clear();
      var response = await Dio().get('$baseURL/api/v1/plants',
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
      var response = await Dio().get('$baseURL/api/v1/tools',
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
      var response = await Dio().get('$baseURL/api/v1/products',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ProductsModel res = ProductsModel.fromJson(response.data);
      // print("from get Prod ${response.data['data'].runtimeType}");

      allproducts = [...?res.data];
      // print("products ${res.data![0].name}");
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
      ProductsModel res = ProductsModel.fromJson(response.data);
      // print("from get Prod by ID ${response.data['data'].runtimeType}");
      return res.data;
    }on DioError catch (e) {
      print("Error from get All products: ${e.response!.data['message']}");
    }
  }

  Future getAllForums() async {
    try {
      allPosts.clear();
      var response = await Dio().get('$baseURL/api/v1/forums',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumModel res = ForumModel.fromJson(response.data);
      allPosts = [...?res.data];
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All forums: $e");
    }
  }

  Future getMyForums() async {
    try {
      myPosts.clear();
      var response = await Dio().get('$baseURL/api/v1/forums/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumModel res = ForumModel.fromJson(response.data);
      myPosts = [...?res.data];
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get my forums: $e");
    }
  }

  Future addForum(
      {required String title,
      required String description,
      required String image}) async {
    try {
      Response response = await Dio().post("$baseURL/api/v1/forums",
          data: {
            "title": title,
            "description": description,
            "imageBase64": image
          },
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));

      print('Forum Added successfully: ${response.data}');

      var retrievedPost = Forum.fromJson(response.data);
      print("retrievedForum fromJson => $retrievedPost");
      getAllForums();
      getMyForums();
      notifyListeners();
    } on DioError catch (e) {
      print('Error Adding forum: ${e.message}');
    }
  }

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
      // print("${AllBlogs[0].name}");
      // print(AllBlogs[0]is Plants);
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get my forums: $e");
    }
  }

  Future signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required context}) async {
    try {
      Response response =
          await Dio().post("$baseURL/api/v1/auth/signup", data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      });

      print('User created: ${response.data}');
      UserModel retrievedUser = UserModel.fromJson(response.data);
      print("retrievedUser fromJson => $retrievedUser");
      AppSharedPref.setToken(accessToken);
      print("token => ${AppSharedPref.getToken()}");

      notifyListeners();
      Fluttertoast.showToast(
            msg: "Signup Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopLayout()));
      
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "${e.response!.data['message']}", toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future signIn({required email, required password, required context}) async {
    try {
      Response response = await Dio().post("$baseURL/api/v1/auth/signin",
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
        getAllForums();
        getMyForums();
        getBlogs();
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
          msg: "${e.response!.data['message']}", toastLength: Toast.LENGTH_SHORT);
    }
  }
}
