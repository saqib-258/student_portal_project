import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/screens/manage_course/course_card.dart';

class ManageCourseScreen extends StatelessWidget {
  const ManageCourseScreen({super.key});
  buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Manage Course"),
        ),
        body: Consumer<CourseSectionProvider>(
            builder: (context, provider, child) {
          if (provider.courses == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: provider.courses!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CourseCard(course: provider.courses![index]),
                  );
                });
          }
        }));
  }
}
