import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../components.dart';
import '../../controller/provider/my_provider.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postDescription = TextEditingController();
  TextEditingController postImageURL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          "Create New Post",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(6, 255, 255, 255),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: defaultColor, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          color: defaultColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Image',
                                    style: TextStyle(color: defaultColor),
                                  ),
                                  content: SizedBox(
                                    height:
                                        screenHeigth(context: context) * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Add Image URL"),
                                        SizedBox(
                                          height:
                                              screenHeigth(context: context) *
                                                  0.01,
                                        ),
                                        TextField(
                                          controller: postImageURL,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        Text(
                          "Add Photo",
                          style: TextStyle(
                              color: defaultColor, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.05,
                ),
                const Text(
                  "Title",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.02,
                ),
                TextField(
                  controller: postTitle,
                  decoration: textFieldBorderStyle(),
                  maxLines: null,
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.02,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.02,
                ),
                TextField(
                  controller: postDescription,
                  maxLines: 7,
                  decoration: textFieldBorderStyle(contetPadding: EdgeInsets.all(10)),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        print("image: ${postImageURL.text.length}");
                        if (!(postTitle.text == "" ||
                            postDescription.text == ""||
                            postImageURL.text=="" )) {
                          myProvider(context: context).addForum(
                              title: postTitle.text,
                              description: postDescription.text,
                              image: postImageURL.text);

                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter all fields",
                              toastLength: Toast.LENGTH_SHORT);
                        }
                      },
                      child: const Text("post"),
                      style: roundedButtonStyle()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
