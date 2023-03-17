import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/teacher_evaluation_question.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/screens/teacher_evaluation/option_button.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.qNo, required this.question, super.key});
  final TeacherEvaluationQuestion question;
  final int qNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q$qNo: ${question.question}",
              style: header2TextStyle,
            ),
            height10(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: TeacherEvaluationQuestion.answers.entries
                      .map((option) => OptionButton(
                          option: option.value,
                          onTap: () {
                            question.answer = option.key;
                            getIt<TeacherEvaluationProvider>().changeAnswer();
                          },
                          isSelected: option.key == question.answer))
                      .toList()),
            ),
            height5(),
          ],
        ),
      ),
    );
  }
}
