import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/screens/teacher_evaluation/assessment_question_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final provider = getIt<TeacherEvaluationProvider>();
    provider.getCourseAndTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Teacher Evaluation")),
      body:
          Consumer<TeacherEvaluationProvider>(builder: (context, provider, _) {
        if (provider.cList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: provider.cList!.length,
                    itemBuilder: (context, index) {
                      TeacherCourse c = provider.cList![index];
                      return GestureDetector(
                        onTap: c.isPending
                            ? () {
                                navigate(context,
                                    AssessmentQuestionScreen(teacherCourse: c));
                              }
                            : null,
                        child: Card(
                          color: c.isPending ? null : primaryColor,
                          child: ListTile(
                            title: Text(
                              c.teacherName,
                              style: c.isPending ? null : textColorStyle,
                            ),
                            subtitle: Text(c.courseName,
                                style: c.isPending ? null : textColorStyle),
                            trailing: Text(c.isPending ? "Pending" : "Done",
                                style: c.isPending ? null : textColorStyle),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
