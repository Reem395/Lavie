import 'package:flutter/material.dart';
import 'package:flutter_hackathon/provider/my_provider.dart';
import 'package:flutter_hackathon/services/AppSharedPref.dart';
import 'package:provider/provider.dart';

import 'signup_login_screens/signup_login_screen.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SpalshScreen(),
      ),
    );
  }
}
