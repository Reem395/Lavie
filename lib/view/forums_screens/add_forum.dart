import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';

import '../../utils/screen_utils.dart';
import '../components.dart';
import '../shop_layout/shop_layout.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController postDescription = TextEditingController();
  TextEditingController postImageURL = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  // dynamic _pickImageError;
  // List<XFile>? _imageFileList;
  String? img64;
  XFile? pickedFile;

  Widget addImage() {
    return Center(
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
              icon: const Icon(Icons.add),
              color: defaultColor,
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
            ),
            Text(
              "Add Photo",
              style:
                  TextStyle(color: defaultColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      pickedFile = await _imagePicker.pickImage(source: source);
      final bytes = File(pickedFile!.path).readAsBytesSync();
      img64 = "data:image/jpeg;base64," + base64Encode(bytes);
      setState(() {});
    } catch (e) {
      print("image error: $e");
    }
  }

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
                pickedFile == null
                    ? addImage()
                    : InkWell(
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery,
                              context: context);
                        },
                        child: Center(
                          child: SizedBox(
                            width: 160,
                            height: screenHeigth(context: context) * 0.16,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              child: Image.file(
                                File(pickedFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                  decoration: textFieldBorderStyle(
                      contetPadding: const EdgeInsets.all(10)),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        print("image: ${postImageURL.text.length}");
                        if (!(postTitle.text == "" ||
                            postDescription.text == "" ||
                            img64 == null)) {
                          myProvider(context: context).addForum(
                              title: postTitle.text,
                              description: postDescription.text,
                              image: img64!);
                          await Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                  builder: (context) => const ShopLayout()),
                              (r) => false);
                          myProvider(context: context).selectedIndex = 0;
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
