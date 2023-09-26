// @dart=2.12
// dart=2.7

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hackathon/controller/remote/API/notifivation_api.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'controller/provider/chat_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/provider/my_provider.dart';
import 'controller/services/app_shared_pref.dart';
import 'view/splash_screen/splash_screen.dart';
import 'controller/local/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotifivationAPI().initNotifications();
  await AppSharedPref.init();
  await DatabaseHelper.helper.getDbInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        navigatorKey: navigatorKey,
        home: const SpalshScreen(),
        // routes:{
          // ChatScreen.route:(context)=>ChatScreen()
        // }
      ),
    );
  }
}
