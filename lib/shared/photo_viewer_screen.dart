import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key, required this.photo});
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: photo,
        child: PhotoView(
          imageProvider: NetworkImage(
            photo,
          ),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
          initialScale: PhotoViewComputedScale.contained,
        ),
      ),
    );
  }
}
