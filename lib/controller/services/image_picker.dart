import 'package:image_picker/image_picker.dart';

class AttachImage {
  static Future pickImage(ImageSource source) async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? pickedImage = await _imagePicker.pickImage(source: source);
      // final bytes = File(pickedImage!.path).readAsBytesSync();
      // String? img64 = "data:image/jpeg;base64," + base64Encode(bytes);
      if (pickedImage != null) {
        print("selected img: ${pickedImage.toString()}");
        final bytes = await pickedImage.readAsBytes();
        return bytes;
      } else {
        print("No image is selected");
      }
    } catch (e) {
      print("Image error: $e");
    }
  }
}
