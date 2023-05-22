import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';

import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course.dart';

import 'package:student_portal/teacher/screens/attendance/main_attendance_screen.dart';
import 'package:student_portal/teacher/screens/evaluation/main_evaluation_screen.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 14.0, right: 14, top: 14, bottom: 8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.courseName,
                style: const TextStyle(fontSize: 18),
              ),
              height5(),
              Text(course.courseCode),
              height5(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        navigate(context, MainAttendanceScreen(course: course));
                      },
                      child: const Text("Attendance")),
                  width10(),
                  ElevatedButton(
                      onPressed: () {
                        navigate(context, MainEvaluationScreen(course: course));
                      },
                      child: const Text("Evaluation")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
