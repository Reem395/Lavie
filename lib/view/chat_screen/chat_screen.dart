import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/provider/chat_provider.dart';
import 'package:flutter_hackathon/controller/remote/API/notifivation_api.dart';
import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:flutter_hackathon/models/message_model/message.dart';
import 'package:flutter_hackathon/utils/screen_size_utils.dart';
import 'package:flutter_hackathon/view/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controller/services/image_picker.dart';
import '../../utils/constants.dart';
import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController _msgController = TextEditingController();
ScrollController _scrollController = ScrollController();
bool isInitialLoading = true;

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
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Sorry Something went wrong!"));
              }
              if (snapshot.connectionState == ConnectionState.waiting && isInitialLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: defaultColor,
                ));
              } else {
                if (isInitialLoading) {
                  isInitialLoading =
                      false; // Set it to false after initial loading.
                }

                final messagesdocs = snapshot.data!.docs;
                print("messagesdocs:${messagesdocs}");
                if (messagesdocs.isNotEmpty) {
                  print(
                      "messagesdocs.first['message'] :${messagesdocs.first['message']}");
                }

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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
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
                                chatprovider(context: context).addMessage(
                                    Message(
                                        message: _msgController.text,
                                        time: FieldValue.serverTimestamp(),
                                        userId: userId!,
                                        userName: AppSharedPref.getUserName()!,
                                        deviceToken:
                                            NotifivationAPI.deviceToken!));
                                NotifivationAPI.sendNotification(
                                    body: _msgController.text);
                                _msgController.clear();
                                _scrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                              }
                            },
                          ),
                          prefixIcon: IconButton(
                              onPressed: () async {
                                Uint8List? img = await AttachImage.pickImage(
                                    ImageSource.gallery);
                                print("UNI $img");
                                //Show Alert
                                if (img != null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentTextStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          content: Image.memory(
                                            img,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // if (isUploading) {
                                                //   return;
                                                // } else {
                                                //   isUploading = true;
                                                // }
                                                try {
                                                  await chatprovider(
                                                          context: context)
                                                      .sendImage(
                                                    file: img,
                                                  );
                                                  NotifivationAPI
                                                      .sendNotification(
                                                          body: "Image");
                                                  // chatprovider(context: context)
                                                  //     .startIndicator();
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  print("error: $e");
                                                }
                                                // finally {
                                                //   isUploading = false;
                                                // }
                                              },
                                              child: chatprovider(
                                                          context: context,
                                                          listen: true)
                                                      .sendImgIndicator
                                                  ? const CircularProgressIndicator()
                                                  : const Text('Send',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              icon: const Icon(Icons.image)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: defaultColor, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: defaultColor, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
