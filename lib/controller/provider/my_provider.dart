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
import '../../models/products_model/products_model.dart';
import '../../models/seeds_model/seeds.dart';
import '../../models/seeds_model/seeds_model.dart';
import '../../models/tools_model/tool.dart';
import '../../models/user_model/user.dart';
import '../../models/user_model/user_model.dart';
import '../../utils/constants.dart';
import '../../view/components.dart';
import '../../view/shop_layout/shop_layout.dart';
import '../local/database/database_helper.dart';
import '../services/app_shared_pref.dart';

class MyProvider with ChangeNotifier {
  int questionNo = 1;
  double totalCartPrice = 180;
  DateTime? currentExamDate;
  DateTime? nextExamDate;
  bool isExamAvailable = false;
  int selectedIndex = 2;
  User? currentUser;
  dynamic userAddress;

  List<Seeds> allSeeds = [];
  List<Widget> allPostImg = [];
  List<Tool> allTools = [];
  List<Plants> allPlants = [];
  List<dynamic> allproducts = [];
  List<Forum> allPosts = [];
  List<Forum> myPosts = [];
  List<Widget> allPostsImgs = [];
  List<Widget> myPostsImgs = [];
  List<dynamic> allBlogs = [];
  List userCart = [];
  double cartTotalPrice = 0.0;
  List<Map<String, int>> cartProdCount =
      []; //contains Id of product and intial count in cart (0)
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

  Future fetchImage(List<Forum> postLis) async {
// Future<Widget> fetchImage(String imgUrl) async {
    // final url = Uri.parse('https://example.com/image.jpg');
    for (var element in postLis) {
      if (element.imageUrl == null) {
        print('imgnull:');

        allPostImg.add(textForImageError());
      } else {
        try {
          String? url = element.imageUrl!.startsWith('/')
              ? "$baseURL${element.imageUrl}"
              : element.imageUrl;
          var response = await Dio().get(url!);

          if (response.statusCode == 200) {
            // handle successful response
            allPostImg.add(Image.network(url));
          } else {
            print('Error else:');

            allPostImg.add(textForImageError());

            // throw Exception('Failed to load image, status code: ${response.statusCode}');
          }
        } catch (error) {
          print('Error loading image: $error');
          allPostImg.add(textForImageError());
        }
      }
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
      // print("allPosts len: ${allPosts.length}");
      // await fetchImage(allPosts);
      // print("postImg len: ${allPostsImgs.length}");
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
      ForumLike res = ForumLike.fromJson(response.data);
      print('res: ${res}');
      print('Liked successfully: ${res.forumId}');
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get forums like: ${e.response!.data['message']}");
    }
  }

  Future commentOnPost(String forumId, String comment) async {
    try {
      var response = await Dio().post('$baseURL/api/v1/forums/$forumId/comment',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })),
          data: {"comment": comment});
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
      {required dynamic productInstance, required BuildContext context}) {
    String prodId = getInstanceId(productInstance: productInstance);
    List productCountMap =
        getProductMap(productInstance: productInstance, context: context);

    for (Map item in productCountMap) {
      if (item.containsKey(prodId)) {
        item[prodId] = (item.values.first) + 1;
        // getCount(product:productInstance,context: context);
        calculateCartTotalPrice(context: context);
        notifyListeners();
      }
    }
  }

  decrementCartItem(
      {required dynamic productInstance,
      required BuildContext context,
      cartId}) {
    String prodId = getInstanceId(productInstance: productInstance);
    List productCountMap =
        getProductMap(productInstance: productInstance, context: context);

    for (Map item in productCountMap) {
      if (item.containsKey(prodId)) {
        if (item.values.first >= 1) {
          item[prodId] = (item.values.first) - 1;
          if (item.values.first == 0) {
            if (cartId != null) {
              deleteFromCart(cartId);
            }
          }
        } else if (item.values.first < 1) {}
        calculateCartTotalPrice(context: context);
        notifyListeners();
      }
    }
  }

  getCount({required product, required BuildContext context}) {
    var prodId = getInstanceId(productInstance: product);
    for (var item in userCart) {
      if (item.productId == prodId) {
        return item.noProductsInCart;
      }
    }
    return prodCount(productInstance: product, context: context);
  }

  getCart() {
    DatabaseHelper.helper.getuserCart().then((value) {
      print("from get : ${value.length}");
      userCart = value;
      // for (var item in userCart) {
      //   var count = item.noProductsInCart;

      // }
      notifyListeners();
      return userCart;
    });
  }

  void deleteFromCart(int cartId) {
    DatabaseHelper.helper.deleteFromDb(cartId).then((value) => value > 0
        ? print('element deleted from cart')
        : print('something went wrong'));
    getCart();
  }

  void updateCart({required Cart myCart, required BuildContext context}) {
    DatabaseHelper.helper.updateDb(myCart).then((value) =>
        value > 0 ? print('cart updated') : print('something went wrong'));
    getCart();
    calculateCartTotalPrice(context: context);
    notifyListeners();
  }

  addToCart({required Cart myCart, required BuildContext context}) {
    if (myCart.noProductsInCart == 0) {
      Fluttertoast.showToast(
          msg: "Please incerase number of products",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (userCart.isNotEmpty) {
        if (!(userCart
            .any((element) => element.productId == myCart.productId))) {
          userCart.add(myCart);
          DatabaseHelper.helper.insertDb(myCart).then((value) =>
              value > 0 ? print('cart Saved') : print('something went wrong'));
          getCart();
        }
      } else {
        userCart.add(myCart);
        DatabaseHelper.helper.insertDb(myCart).then((value) =>
            value > 0 ? print('cart Saved') : print('something went wrong'));
        getCart();
      }
      for (var element in userCart) {
        print("usercart: ${element.productId}");
      }
    }
    calculateCartTotalPrice(context: context);
    notifyListeners();
  }

  elementToRemove({required elementToRemove, required BuildContext context}) {
    int cartId = elementToRemove.id;
    userCart.remove(elementToRemove);
    calculateCartTotalPrice(context: context);
    deleteFromCart(elementToRemove.id);
    notifyListeners();
  }

  calculateCartTotalPrice({required BuildContext context}) {
    cartTotalPrice = 0.0;
    print("from calcu userCart ${userCart.length}");
    getCart();
    for (var item in userCart) {
      var foundedProduct = productInCart(cartProduct: item, context: context);
      print("from calcu foundedProduct ${foundedProduct}");

      var price = foundedProduct.price;
      print("from calcu price ${price}");

      var count = item.noProductsInCart;
      print("from calcu userCart ${userCart.length}");

      cartTotalPrice += price * count;
    }
  }
//****************** User ********************************* */

  Future getCurrentUser() async {
    try {
      var response = await Dio().get('$baseURL/api/v1/user/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      currentUser = User.fromJson(response.data['data']);
      userAddress = currentUser?.address;
      print("userAddress: ${userAddress}");
      // }
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get current user: ${e.response!.data['message']}");
    }
    return null;
  }

  Future editCurrentUser(
      {String? firstName,
      String? lastName,
      String? email,
      String? address}) async {
    try {
      var response = await Dio().patch('$baseURL/api/v1/user/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })),
          data: {
            "firstName": firstName ?? currentUser!.firstName,
            "lastName": lastName ?? currentUser!.lastName,
            "email": email ?? currentUser!.email,
            "address": address ?? currentUser!.address
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
        getCurrentUser();
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
        await getCurrentUser();

        notifyListeners();

        print("User token is not null: $userToken");
        Fluttertoast.showToast(
            msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => userAddress == null
                    ? const ClaimFreeSeed()
                    : ShopLayout()));
      }
    } on DioError catch (e) {
      print('Error Login user: $e');
      Fluttertoast.showToast(
          msg: "${e.response!.data['message']}",
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  checkImage() {}
}
