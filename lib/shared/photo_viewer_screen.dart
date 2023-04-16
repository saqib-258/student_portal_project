import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key, required this.photo});
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: photo,
          child: Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(
                  photo,
                ),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                initialScale: PhotoViewComputedScale.contained,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: textColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
