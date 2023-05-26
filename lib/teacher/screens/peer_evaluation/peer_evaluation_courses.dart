import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/teacher/providers/peer_evaluation_provider.dart';
import 'package:student_portal/teacher/screens/peer_evaluation/peer_evaluation_question_screen.dart';

class PeerEvaluationCourses extends StatefulWidget {
  const PeerEvaluationCourses({super.key});

  @override
  State<PeerEvaluationCourses> createState() => _PeerEvaluationCoursesState();
}

class _PeerEvaluationCoursesState extends State<PeerEvaluationCourses>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<PeerEvaluationProvider>().getEvaluationTeachersCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Evaluation")),
      body: Consumer<PeerEvaluationProvider>(builder: (context, provider, _) {
        if (provider.tList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.tList!.isEmpty) {
          return const Center(
            child: Text("No data found"),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.tList!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PeerEvaluationQuestionScreen(
                              teacherCourse: provider.tList![index],
                            )));
                provider.getTeacherEvaluationQuestions();
              },
              child: Card(
                elevation: 4,
                color: provider.tList![index].isPending ? null : primaryColor,
                child: ListTile(
                  title: Text(
                    provider.tList![index].teacherName,
                    style: provider.tList![index].isPending
                        ? null
                        : textColorStyle,
                  ),
                  subtitle: Text(provider.tList![index].courseName,
                      style: provider.tList![index].isPending
                          ? null
                          : textColorStyle),
                  trailing: Text(
                      provider.tList![index].isPending ? "Pending" : "Done",
                      style: provider.tList![index].isPending
                          ? null
                          : textColorStyle),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
