import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/screens/teacher_evaluation/question_card.dart';
import 'package:student_portal/teacher/providers/peer_evaluation_provider.dart';

class PeerEvaluationQuestionScreen extends StatelessWidget {
  const PeerEvaluationQuestionScreen({super.key, required this.teacherCourse});
  final TeacherCourse teacherCourse;

  showLeaveDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AppConfirmDialog(
            title: "Are you sure you want to leave evaluation?",
            onConfirm: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showLeaveDialog(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: textColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              showLeaveDialog(context);
            },
          ),
          title: const Text("Teacher Evaluation"),
        ),
        body: Consumer<PeerEvaluationProvider>(builder: (context, provider, _) {
          if (provider.qList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      teacherCourse.teacherName,
                      style: header2TextStyle.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                        '${provider.qList!.where((element) => element.answer != null).length}/${provider.qList!.length}')
                  ],
                ),
                Text(
                  teacherCourse.courseName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Divider(
                  thickness: 1,
                  height: 20,
                ),
                height10(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: provider.qList!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: QuestionCard(
                                provider: provider,
                                qNo: index + 1,
                                question: provider.qList![index],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: AppButton(
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: textColor),
                              ),
                              onTap: () async {
                                if (provider.qList!
                                    .where((element) => element.answer == null)
                                    .isNotEmpty) {
                                  showToast("Please give all the answers");
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AppConfirmDialog(
                                          title:
                                              "Are you sure you want to submit?",
                                          onConfirm: () async {
                                            bool? isDone = await provider
                                                .evaluatePeerTeacher(
                                                    teacherCourse.id);
                                            if (isDone != null) {
                                              showToast(
                                                  "Submitted successfully");
                                              teacherCourse.isPending = false;
                                              provider.notify();
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            }
                                          }));
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
