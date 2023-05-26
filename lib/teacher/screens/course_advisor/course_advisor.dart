import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/providers/course_advisor_provider.dart';
import 'package:student_portal/teacher/screens/course_advisor/course_advisor_students.dart';

class CourseAdvisor extends StatefulWidget {
  const CourseAdvisor({super.key});

  @override
  State<CourseAdvisor> createState() => _CourseAdvisorState();
}

class _CourseAdvisorState extends State<CourseAdvisor> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<CourseAdvisorProvider>().getCourseAdvisor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Advisor"),
      ),
      body: Consumer<CourseAdvisorProvider>(builder: (context, provider, _) {
        if (provider.cList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.cList!.isEmpty) {
          return const Center(child: Text("No data found"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.cList!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                onTap: () {
                  navigate(
                      context,
                      CourseAdvisorStudentScreen(
                          model: provider.cList![index]));
                },
                title: Text(
                    'BS${provider.cList![index].program}-${provider.cList![index].semester}${provider.cList![index].section}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
              ),
            );
          },
        );
      }),
    );
  }
}
