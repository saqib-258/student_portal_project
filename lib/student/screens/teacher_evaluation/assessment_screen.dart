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
  final provider = getIt<TeacherEvaluationProvider>();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    provider.getCourseAndTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Evaluation")),
      body:
          Consumer<TeacherEvaluationProvider>(builder: (context, provider, _) {
        if (provider.model == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.model!.courses!.isEmpty) {
          return const Center(child: Text("No data found"));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CountdownWidget(
                  targetDate: DateTime.parse(
                      convertDateFormat(provider.model!.endDate!))),
              Expanded(
                child: ListView.builder(
                    itemCount: provider.model!.courses!.length,
                    itemBuilder: (context, index) {
                      TeacherCourse c = provider.model!.courses![index];
                      return GestureDetector(
                        onTap: c.isPending
                            ? () {
                                navigate(context,
                                    AssessmentQuestionScreen(teacherCourse: c));
                                getIt<TeacherEvaluationProvider>()
                                    .getTeacherEvaluationQuestions(c.id);
                              }
                            : null,
                        child: Card(
                          elevation: 4,
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

class CountdownWidget extends StatefulWidget {
  final DateTime targetDate;

  const CountdownWidget({super.key, required this.targetDate});

  @override
  CountdownWidgetState createState() => CountdownWidgetState();
}

class CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    final currentTime = DateTime.now();
    _remainingTime = widget.targetDate.difference(currentTime);
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remainingTime.inDays;
    final hours = _remainingTime.inHours.remainder(24);
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${days}d ${hours}h ${minutes}m ${seconds}s',
        style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
