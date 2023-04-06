// @dart=2.7
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'controller/provider/chat_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/view/signup_login_screens/signup_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'controller/provider/my_provider.dart';
import 'controller/services/app_shared_pref.dart';
import 'view/splash_screen/splash_screen.dart';
import 'controller/local/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppSharedPref.init();
  await DatabaseHelper.helper.getDbInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => MyProvider(),
    ),
      ChangeNotifierProvider(
      create: (context) => ChatProvider(),
    ),
    ],
    child:MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SpalshScreen(),
      ),
    );
  }
}
