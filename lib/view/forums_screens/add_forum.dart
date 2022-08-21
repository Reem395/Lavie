import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants.dart';

import '../../components.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postDescription = TextEditingController();
  TextEditingController imageURL = TextEditingController();
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
                                          controller: imageURL,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Back'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Save'),
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
                  decoration: textFieldBorderStyle(),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("post"),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size.infinite),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStateProperty.all(defaultColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    side: BorderSide(
                                        color: defaultColor, width: 1.5))),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
