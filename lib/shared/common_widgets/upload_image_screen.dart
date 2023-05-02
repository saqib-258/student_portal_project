import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

class UploadImageScreen extends StatelessWidget {
  UploadImageScreen({super.key, required this.photo, required this.onUpload});
  final File photo;
  final VoidCallback onUpload;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Challan"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (isUploading) {
            return false;
          } else {
            return true;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: PhotoView(
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                imageProvider: FileImage(
                  photo,
                ),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                initialScale: PhotoViewComputedScale.contained * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryCardColor),
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isUploading = true;
                      onUpload();
                    },
                    child: const Text("Upload"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
