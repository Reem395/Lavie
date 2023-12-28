import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/provider/cart_provider.dart';
import 'package:flutter_hackathon/controller/provider/chat_provider.dart';
import 'package:flutter_hackathon/controller/provider/exam_provider.dart';
import 'package:flutter_hackathon/controller/provider/forums_provider.dart';
import 'package:flutter_hackathon/controller/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../controller/provider/global_provider.dart';
import '../controller/services/app_shared_pref.dart';

Color defaultColor = const Color.fromARGB(255, 30, 190, 35);
Color lightGrey = const Color.fromARGB(31, 190, 187, 187);
String baseURL = "https://lavie.orangedigitalcenteregypt.com";
String? userId = AppSharedPref.getUserId();
String? userName = AppSharedPref.getUserName();
String? usermail = AppSharedPref.getUserMail();
String sender = "Ksender";
String reciever = "Kreciever";
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum IndicatorType { login, sendImg }

GlobalProvider myProvider({required BuildContext context, bool listen = false}) {
  return Provider.of<GlobalProvider>(context, listen: listen);
}

UserProvider userProvider(
    {required BuildContext context, bool listen = false}) {
  return Provider.of<UserProvider>(context, listen: listen);
}

ExamProvider examProvider(
    {required BuildContext context, bool listen = false}) {
  return Provider.of<ExamProvider>(context, listen: listen);
}

ChatProvider chatprovider(
    {required BuildContext context, bool listen = false}) {
  return Provider.of<ChatProvider>(context, listen: listen);
}

CartProvider cartProvider(
    {required BuildContext context, bool listen = false}) {
  return Provider.of<CartProvider>(context, listen: listen);
}

ForumProvider forumProvider(
    {required BuildContext context, bool listen = false}) {
  return Provider.of<ForumProvider>(context, listen: listen);
}
