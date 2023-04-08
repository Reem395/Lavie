import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:flutter_hackathon/models/message_model/message.dart';
import 'package:flutter_hackathon/view/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/constants.dart';
import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController _msgController = TextEditingController();
ScrollController _scrollController =  ScrollController();
class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              laVieLogo(),
              const Text(
                " Chat",
                style: TextStyle(
                    fontFamily: 'Meddon',
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Sorry Something went wrong!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: defaultColor,
            ));
            ;
          } else {
            final messagesdocs = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messagesdocs.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          message: messagesdocs[index]['message'],
                          sentBy: messagesdocs[index]['userId'] == userId
                              ? sender
                              : reciever,
                              userName: messagesdocs[index]['userName'],
                        );
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                  child: TextField(
                    controller: _msgController,
                    onEditingComplete: () {},
                    decoration: InputDecoration(
                      suffixIconColor: defaultColor,
                      hintText: "Message",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_msgController.text.isNotEmpty ||
                              _msgController.text != "") {
                            chatprovider(context: context).addMessage(Message(
                                message: _msgController.text,
                                time: DateTime.now(),
                                userId: userId!,
                                userName: AppSharedPref.getUserName()!));
                            _msgController.clear();
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          }
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: defaultColor, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: defaultColor, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
