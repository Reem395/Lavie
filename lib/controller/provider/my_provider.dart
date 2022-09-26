import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hackathon/models/blogs_model/blogs_model.dart';
import 'package:flutter_hackathon/models/cart_model/cart.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
import 'package:flutter_hackathon/models/products_model/product_single_model/product_single_model.dart';
import 'package:flutter_hackathon/models/tools_model/tools_model.dart';
import 'package:flutter_hackathon/view/signup_login_screens/claim_free_seed.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/forum_model/Forum.dart';
import '../../models/forum_model/forum_comment.dart';
import '../../models/forum_model/forum_like.dart';
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
  double totalCartPrice = 180;
  DateTime? currentExamDate;
  DateTime? nextExamDate;
  bool isExamAvailable = false;
  int selectedIndex = 2;
  User? currentUser;

  List<Seeds> allSeeds = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  List<Forum> allPosts = [];
  List<Forum> myPosts = [];
  List<dynamic> allBlogs = [];
  List userCart = [];
  List<Map<String, int>> cartProdCount =[]; //contains Id of product and intial count in cart (0)
  List<Map<String, int>> cartPlantCount = [];
  List<Map<String, int>> cartSeedsCount = [];
  List<Map<String, int>> cartToolsCount = [];

//****************** Exams ********************************* */

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

//****************** get seed, plants, tools, products ********************************* */

  Future getAllSeeds() async {
    try {
      allSeeds.clear();
      cartSeedsCount.clear();
      var response = await Dio().get('$baseURL/api/v1/seeds',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      SeedsModel res = SeedsModel.fromJson(response.data);
      allSeeds = [...?res.data];
      for (var item in allSeeds) {
        cartSeedsCount.add({"${item.seedId}": 0});
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
      cartPlantCount.clear();
      var response = await Dio().get('$baseURL/api/v1/plants',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      PlantsModel res = PlantsModel.fromJson(response.data);
      allPlants = [...?res.data];
      for (var item in allPlants) {
        cartPlantCount.add({"${item.plantId}": 0});
      }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All plants: $e");
    }
  }

  Future getAllTools() async {
    try {
      allTools.clear();
      cartToolsCount.clear();
      var response = await Dio().get('$baseURL/api/v1/tools',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ToolsModel res = ToolsModel.fromJson(response.data);
      allTools = [...?res.data];
      for (var item in allTools) {
        cartToolsCount.add({"${item.toolId}": 0});
      }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All Tools: $e");
    }
  }

  Future getAllProducts() async {
    try {
      allproducts.clear();
      cartProdCount.clear();
      var response = await Dio().get('$baseURL/api/v1/products',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ProductsModel res = ProductsModel.fromJson(response.data);

      allproducts = [...?res.data];
      for (var item in allproducts) {
        cartProdCount.add({"${item.productId}": 0});
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


//****************** Forums ********************************* */

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

  Future likePost(String forumId) async {
    try {
      var response = await Dio().post('$baseURL/api/v1/forums/$forumId/like',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      // print('Liked successfully');
      ForumLike res = ForumLike.fromJson(response.data);
      print('res: ${res}');
      print('Liked successfully: ${res.forumId}');
      // getAllForums();
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get forums like: ${e.response!.data['message']}");
    }
  }

  Future commentOnPost(String forumId,String comment) async {
    try {
      var response = await Dio().post('$baseURL/api/v1/forums/$forumId/comment',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })),data: {"comment":comment});
      ForumComment res = ForumComment.fromJson(response.data);
      print('res: ${res}');
      print('commented successfully: ${res.forumId}');
      notifyListeners();
    } on DioError catch (e) {
      print("Error from commentOnPost: ${e.response!.data['message']}");
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
      print('Error Adding forum: ${e.response!.data['message']}');
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

//****************** Cart ********************************* */

  incrementCartItem(
      {required List productMap, required dynamic productInstance}) {
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
    for (Map item in productMap) {
      if (item.containsKey(prodId)) {
        item[prodId] = (item.values.first) + 1;
        notifyListeners();
      }
    }
  }

  decrementCartItem(
      {required List productMap, required dynamic productInstance}) {
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
    for (Map item in productMap) {
      if (item.containsKey(prodId)) {
        if (item.values.first >= 1) {
          item[prodId] = (item.values.first) - 1;
        }
        notifyListeners();
      }
    }
  }

// addToCart({required List productMap, required dynamic productInstance,required Cart myCart}){

// }
  List oldCart = [];
  addToCart({required Cart myCart}) {
    oldCart.clear();
    oldCart = [...userCart];
    if (oldCart.isNotEmpty) {
      for (Cart item in oldCart) {
        if (item.productId != myCart.productId) {
          userCart.add(myCart);
        }
      }
    } else {
      userCart.add(myCart);
    }
    notifyListeners();
  }

  removeFromCart() {}
//****************** User ********************************* */

  Future getCurrentUser() async {
    try {
      var response = await Dio().get('$baseURL/api/v1/user/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      currentUser = User.fromJson(response.data['data']);
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get current user: ${e.response!.data['message']}");
    }
    return null;
  }

  Future editCurrentUser({String? firstName,String? lastName,String? email,String? address}) async {
    try {
      var response = await Dio().patch('$baseURL/api/v1/user/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })),
          data: {
            "firstName": firstName??currentUser!.firstName,
            "lastName": lastName??currentUser!.lastName,
            "email": email??currentUser!.email,
            "address": address??currentUser!.address
          });
       print("user edited : ${User.fromJson(response.data['data'])}");
      await getCurrentUser();
    } on DioError catch (e) {
      print("Error from get current user: ${e.response!.data['message']}");
    }
    return null;
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
      userToken = retrievedUser.data!.accessToken;
      AppSharedPref.setToken(userToken);
      userId = retrievedUser.data!.user!.userId;
      AppSharedPref.setUserId(userId);
      // print("token => ${AppSharedPref.getToken()}");

      if (userToken != null) {
        getAllTools();
        getAllPlants();
        getAllSeeds();
        getAllProducts();
        getAllForums();
        getMyForums();
        getBlogs();
        notifyListeners();

        print("User token is not null: $userToken");
        Fluttertoast.showToast(
            msg: "Signup Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ClaimFreeSeed()));
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "${e.response!.data['message']}",
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future signIn({required email, required password, required context}) async {
    try {
      Response response = await Dio().post("$baseURL/api/v1/auth/signin",
          data: {"email": email, "password": password});

      print('User Login : ${response.data}');

      UserModel retrievedUser = UserModel.fromJson(response.data);
      userToken = retrievedUser.data!.accessToken;
      AppSharedPref.setToken(userToken);
      userId = retrievedUser.data!.user!.userId;
      AppSharedPref.setUserId(userId);
      print("userID: $userId");
      AppSharedPref.setUserMail(email);
      print("token => ${AppSharedPref.getToken()}");
      if (userToken != null) {
        getAllTools();
        getAllPlants();
        getAllSeeds();
        getAllProducts();
        getAllForums();
        getMyForums();
        getBlogs();
        notifyListeners();

        print("User token is not null: $userToken");
        Fluttertoast.showToast(
            msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShopLayout()));
      }
    } on DioError catch (e) {
      print('Error Login user: $e');
      Fluttertoast.showToast(
          msg: "${e.response!.data['message']}",
          toastLength: Toast.LENGTH_SHORT);
    }
  }

}
