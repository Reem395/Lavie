import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class FullImageScreen extends StatelessWidget {
  const FullImageScreen({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: PhotoView(
            imageProvider:NetworkImage(image),
          minScale: PhotoViewComputedScale.contained *1,
          maxScale: PhotoViewComputedScale.covered * 2,
          )),
    );
  }
}
