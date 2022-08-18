import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> navPages = [
    Text("Page1"),
    Text("Page2"),
    Text("Page3"),
    Text("Page4"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 2 + 145,
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // gradient: sLinearColorBlue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        Positioned(
                          height: 555,
                          child: CircleAvatar(
                            radius: 60.0,
                            child: ClipRRect(
                              child: Image.asset('assets/account.jpg'),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}


//My Provider
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_hackathon/models/plants_model/plants.dart';
// import 'package:flutter_hackathon/models/plants_model/plants_model.dart';
// import 'package:flutter_hackathon/models/tools_model/tools_model.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../models/seeds_model/seeds.dart';
// import '../models/seeds_model/seeds_model.dart';
// import '../models/tools_model/tool.dart';
// import '../models/user_model/user.dart';
// import '../models/user_model/user_model.dart';
// import '../services/app_shared_pref.dart';
// import '../widgets/shop_layout.dart';
// // import 'package:flutter_hackathon/models/user/user_model.dart';

// class MyProvider with ChangeNotifier {
//   List<Seeds> allSeeds = [];
//   List<Tool> allTools = [];
//   List<Plants> allPlants = [];
//   List<dynamic> allproducts = [];
//   String? accessToken = AppSharedPref.getToken();
//   String baseUrl = "https://lavie.orangedigitalcenteregypt.com/api/v1/";
//   Future<List<Seeds>> getAllSeeds() async {
//     try {
//       allSeeds.clear();
//       var response = await Dio().get('${baseUrl}seeds',
//           options: Options(
//               headers: ({
//             'Authorization': 'Bearer ${AppSharedPref.getToken()}'
//           })));
//       SeedsModel res = SeedsModel.fromJson(response.data);
//       allSeeds = [...?res.data];
//       allproducts.addAll(allSeeds);
//       notifyListeners();
//     } catch (e) {
//       print("Error from get All seeds: $e");
//     }
//     return allSeeds;
//   }

//   Future<List<Plants>> getAllPlants() async {
//     try {
//       allPlants.clear();
//       var response = await Dio().get('${baseUrl}plants',
//           options: Options(
//               headers: ({
//             'Authorization': 'Bearer ${AppSharedPref.getToken()}'
//           })));
//       PlantsModel res = PlantsModel.fromJson(response.data);
//       allPlants = [...?res.data];
//       allproducts.addAll(allPlants);
//       notifyListeners();
//     } catch (e) {
//       print("Error from get All plants: $e");
//     }
//     return allPlants;
//   }

//   Future<List<Tool>> getAllTools() async {
//     try {
//       allTools.clear();
//       var response = await Dio().get('${baseUrl}tools',
//           options: Options(
//               headers: ({
//             'Authorization': 'Bearer ${AppSharedPref.getToken()}'
//           })));
//       ToolsModel res = ToolsModel.fromJson(response.data);
//       allTools = [...?res.data];
//       allproducts.addAll(allTools);
//       notifyListeners();
//     } catch (e) {
//       print("Error from get All Tools: $e");
//     }
//     return allTools;
//   }

// //   Future<List> getAllProducts()async{
// //     // allproducts.clear();
// //     // allproducts.addAll(allPlants);
// //     // allproducts.addAll(allSeeds);
// //     // allproducts.addAll(allTools);
// // try {
// //       allTools.clear();
// //       var response = await Dio().get('${baseUrl}products',
// //           options: Options(
// //               headers: ({
// //             'Authorization': 'Bearer ${AppSharedPref.getToken()}'
// //           })));
// //       ToolsModel res = ToolsModel.fromJson(response.data);
// //       allTools = [...?res.data];
// //       allproducts.addAll(allTools);
// //       notifyListeners();
// //     } catch (e) {
// //       print("Error from get All Tools: $e");
// //     }
// //     notifyListeners();
// //   }
//    signUp(User user) async {
//     try {
//       Response response = await Dio().post(
//           "https://lavie.orangedigitalcenteregypt.com/api/v1/auth/signup",
//           data: user);

//       print('User created: ${response.data}');

//       var retrievedUser = User.fromJson(response.data);
//       print("retrievedUser fromJson => $retrievedUser");
//       notifyListeners();
//     } catch (e) {
//       print('Error creating user: $e');
//     }
//   }

//    signIn({required email, required password, required context}) async {
//     try {
//       Response response = await Dio().post(
//           "https://lavie.orangedigitalcenteregypt.com/api/v1/auth/signin",
//           data: {"email": email, "password": password});

//       print('User Login : ${response.data}');

//       UserModel retrievedUser = UserModel.fromJson(response.data);
//       accessToken = retrievedUser.data!.accessToken;
//       AppSharedPref.setToken(accessToken);
//       AppSharedPref.setUserMail(email);
//       print("token => ${AppSharedPref.getToken()}");
//       notifyListeners();
//       if (accessToken != null) {
//         getAllTools();
//         getAllPlants();
//         getAllSeeds();
//         print("User token is not null: $accessToken");
//         // Fluttertoast.showToast(
//         //     msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ShopLayout()));
//       } 
//     } catch (e) {
//       print('Error Login user: $e');
//       Fluttertoast.showToast(
//             msg: "Wrong email or password", toastLength: Toast.LENGTH_SHORT);
//     }
//   }
// }
