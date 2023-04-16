import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/providers/fee_provider.dart';

class UploadChallanScreen extends StatelessWidget {
  const UploadChallanScreen({super.key, required this.photo, required this.id});
  final File photo;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Challan"),
      ),
      body: Column(
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
                  child: const Text("Upload"),
                  onPressed: () async {
                    EasyLoading.show(
                        indicator: const CircularProgressIndicator());
                    await getIt<FeeProvider>().uploadChallan(photo, id);
                    await Future.delayed(const Duration(seconds: 1));
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
