import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key? key, required this.image}) : super(key: key);
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained * 1.0,
          maxScale: PhotoViewComputedScale.contained * 2.0,
          initialScale: PhotoViewComputedScale.contained * 1.0,
          imageProvider: image.image,
        ),
      ),
    );
  }
}
