import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_course.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';

class TeacherEvaluationResultScreen extends StatefulWidget {
  const TeacherEvaluationResultScreen(
      {super.key, required this.teacherEvaluationCourse});
  final TeacherEvaluationCourse teacherEvaluationCourse;
  @override
  State<TeacherEvaluationResultScreen> createState() =>
      _TeacherEvaluationResultScreenState();
}

class _TeacherEvaluationResultScreenState
    extends State<TeacherEvaluationResultScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final provider = getIt<TeacherEvaluationResultProvider>();
    provider.getTeacherEvaluationResult(
        widget.teacherEvaluationCourse.teacherId,
        widget.teacherEvaluationCourse.courseCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Evaluation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.teacherEvaluationCourse.teacherName,
              style: header1TextStyle),
          Text(widget.teacherEvaluationCourse.courseName),
          const Divider(
            thickness: 1.2,
          ),
          height10(),
          Expanded(child: Consumer<TeacherEvaluationResultProvider>(
              builder: (context, provider, _) {
            if (provider.eList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.eList!.isEmpty) {
              return const Center(
                child: Text("No data found"),
              );
            }
            return ListView.builder(
                itemCount: provider.eList!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(provider.eList![index].question),
                              )),
                          Expanded(
                              child: Text(
                            '${provider.eList![index].percentage} %',
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  );
                });
          }))
        ]),
      ),
    );
  }
}
