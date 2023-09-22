import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/message_model/message.dart';

class ChatProvider with ChangeNotifier {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> addMessage(Message msg) {
    return messages.add(msg.toJson()).then((value) {
      print("mesagge Added, userId: ${msg.userId}");
      notifyListeners();
    }).catchError((error) {
      print("Failed to add message: $error");
    });
  }
}
