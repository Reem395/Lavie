import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/message_model/message.dart';

import '../../utils/constants.dart';
import '../remote/API/notifivation_api.dart';
import '../services/app_shared_pref.dart';

class ChatProvider with ChangeNotifier {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool sendImgIndicator = false;

  Future<void> addMessage(Message msg) {
    return messages.add(msg.toJson()).then((value) {
      print("mesagge Added, userId: ${msg.userId}");
      notifyListeners();
    }).catchError((error) {
      print("Failed to add message: $error");
    });
  }

  Future<String> uploadImageToStorage({required Uint8List file}) async {
    dynamic time = DateTime.now().millisecondsSinceEpoch.toString();
    print("time : $time");
    String name = 'chatImage_$time$userId';
    Reference ref = _storage.ref().child('chatImage').child(name);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadUrl = await snapShot.ref.getDownloadURL();
    notifyListeners();
    return downloadUrl;
  }

  Future sendImage({required Uint8List file}) async {
    startIndicator();
    String? downloadUrl = await uploadImageToStorage(file: file);
    await addMessage(Message(
        message: downloadUrl,
        time: FieldValue.serverTimestamp(),
        userId: userId!,
        userName: AppSharedPref.getUserName()!,
        deviceToken: NotifivationAPI.deviceToken!));
    stopIndicator();
    notifyListeners();
  }

  void startIndicator() {
    sendImgIndicator = true;
    notifyListeners();
  }

  void stopIndicator() {
    sendImgIndicator = false;
    notifyListeners();
  }
}
