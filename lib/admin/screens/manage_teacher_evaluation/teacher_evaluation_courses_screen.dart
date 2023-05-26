import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/admin/screens/manage_teacher_evaluation/new_teacher_evaluation.dart';
import 'package:student_portal/admin/screens/manage_teacher_evaluation/teacher_evaluation_result_screen.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';

class TeacherEvaluationCoursesScreen extends StatefulWidget {
  const TeacherEvaluationCoursesScreen({super.key});

  @override
  State<TeacherEvaluationCoursesScreen> createState() =>
      _TeacherEvaluationCoursesState();
}

class _TeacherEvaluationCoursesState
    extends State<TeacherEvaluationCoursesScreen> with AfterLayoutMixin {
  final provider = getIt<TeacherEvaluationResultProvider>();
  String? selectedVal;

  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {}

  List<DropdownMenuItem> getItems() {
    provider.sessionsList = ["FALL2019", "SPRING2020", "FALL2020"];
    List<DropdownMenuItem> dList = [];
    dList = provider.sessionsList!
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();

    return dList;
  }

  getCourses() {
    provider.getTeacherEvaluationCourse(selectedVal!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Evalution"),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16), shape: const StadiumBorder()),
        onPressed: () {
          navigate(context, NewTeacherEvaluation());
        },
        child: const Text("Start New Evaluation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                  hint: const Text("Select session"),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  value: selectedVal,
                  items: getItems(),
                  onChanged: (val) {
                    setState(() {
                      selectedVal = val;
                      getCourses();
                    });
                  }),
            ),
            height20(),
            Text(
              "Teacher Courses",
              style: header1TextStyle,
            ),
            height10(),
            Consumer<TeacherEvaluationResultProvider>(
                builder: (context, provider, _) {
              if (selectedVal == null) {
                return const Center(
                  child: Text("Please select session"),
                );
              }
              if (provider.cList == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.cList!.isEmpty) {
                return const Center(
                  child: Text("No record found"),
                );
              }

              return Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: provider.cList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigate(
                              context,
                              TeacherEvaluationResultScreen(
                                  teacherEvaluationCourse:
                                      provider.cList![index]));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(provider.cList![index].teacherName),
                            subtitle: Text(provider.cList![index].courseName),
                            trailing: Text(provider.cList![index].courseCode),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
