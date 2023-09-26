import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource source) async {
  try {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? pickedFile = await _imagePicker.pickImage(source: source);
    // final bytes = File(pickedFile!.path).readAsBytesSync();
    // String? img64 = "data:image/jpeg;base64," + base64Encode(bytes);
    if (pickedFile != null) {
      final bytes = File(pickedFile.path).readAsBytesSync();
      return bytes;
    } else {
      print("No image is selected");
    }
  } catch (e) {
    print("Image error: $e");
  }
}
