import 'package:flutter/material.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';

class ContestAttendanceImagesScreen extends StatelessWidget {
  const ContestAttendanceImagesScreen({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendace Images"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10, mainAxisSpacing: 6, crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            navigate(
                context,
                PhotoViewerScreen(
                  photo: getFileUrl("AttendanceImages", images[index]),
                ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              getFileUrl("AttendanceImages", images[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
