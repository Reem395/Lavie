import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model/user.dart';
import '../../models/user_model/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/token_utils.dart';
import '../../view/shop_layout/shop_layout.dart';
import '../../view/signup_login_screens/claim_free_seed.dart';
import '../services/app_shared_pref.dart';
import 'forums_provider.dart';
import 'global_provider.dart';

class UserProvider with ChangeNotifier {
  final GlobalProvider myProvider;
  final ForumProvider forumProvider;

  UserProvider(this.myProvider, this.forumProvider);

  bool loginIndicator = false;
  int selectedIndex = 2;
  User? currentUser;
  dynamic userAddress;

  //****************** User ********************************* */

  Future getCurrentUser() async {
    try {
      var response = await Dio().get('$baseURL/api/v1/user/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      currentUser = User.fromJson(response.data['data']);
      AppSharedPref.setUserName(
          "${currentUser!.firstName} ${currentUser!.lastName}");
      userAddress = currentUser?.address;
      print("userAddress: $userAddress");
      // }
      notifyListeners();
    } on DioError {
      // print("Error from get current user: ${e.response!.data['message']}");
      print("Error from get current user:");
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
        myProvider.getAllTools();
        myProvider.getAllPlants();
        myProvider.getAllSeeds();
        myProvider.getAllProducts();
        forumProvider.getAllForums();
        forumProvider.getMyForums();
        myProvider.getBlogs();
        getCurrentUser();
        AppSharedPref.setUserName(
            "${retrievedUser.data!.user!.firstName} ${retrievedUser.data!.user!.lastName}");
        notifyListeners();

        print("User token is not null: $userToken");
        Fluttertoast.showToast(
            msg: "Signup Successfully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ClaimFreeSeed()));
      }
    } on DioError catch (e) {
      if (e.response!.statusCode! >= 500) {
        Fluttertoast.showToast(
            msg: "Sorry Try again Later", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(
            msg: "${e.response!.data['message']}",
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  Future signIn({required email, required password, required context}) async {
    try {
      startIndicator();
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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
        myProvider.getAllTools();
        myProvider.getAllPlants();
        myProvider.getAllSeeds();
        myProvider.getAllProducts();
        forumProvider.getAllForums();
        forumProvider.getMyForums();
        myProvider.getBlogs();
        await getCurrentUser();
        AppSharedPref.setUserName(
            "${retrievedUser.data!.user!.firstName} ${retrievedUser.data!.user!.lastName}");
        selectedIndex = 2;
        await _firebaseMessaging.subscribeToTopic('all_users');
        notifyListeners();
        print("User token is not null: $userToken");
        Fluttertoast.showToast(
            msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
        stopIndicator();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => userAddress == null
                    ? const ClaimFreeSeed()
                    : const ShopLayout()));
      }
    } on DioError catch (e) {
      stopIndicator();
      if (e.response!.statusCode! >= 500) {
        Fluttertoast.showToast(
            msg: "Sorry Try again Later", toastLength: Toast.LENGTH_SHORT);
      } else {
        print('Error Login user: $e');
        Fluttertoast.showToast(
            msg: "${e.response!.data['message']}",
            toastLength: Toast.LENGTH_SHORT);
      }
      notifyListeners();
    }
  }

  stopIndicator() {
    print("Stop");
    loginIndicator = false;
    notifyListeners();
  }

  startIndicator() {
    print("Start");
    loginIndicator = true;
    notifyListeners();
  }
}
