import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/screens/evaluation/student_evaluation_screen.dart';

// ignore: must_be_immutable
class MainEvaluationScreen extends StatelessWidget {
  MainEvaluationScreen({super.key, required this.course});
  final Course course;
  List<CourseSection>? cList;
  List<DropdownMenuItem> getItems() {
    final provider = getIt<CourseSectionProvider>();
    cList = provider.cList!
        .where((c) => c.courseCode == course.courseCode)
        .toList();
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < cList!.length; i++) {
      items.add(DropdownMenuItem(
          value: "${cList![i].id}-${cList![i].section}",
          child: Text(
              "BS${cList![i].program}-${cList![i].semester}${cList![i].section}")));
    }
    return items;
  }

  selectSectionSemesterDialog(BuildContext context) {
    TextEditingController totalController = TextEditingController();
    TextEditingController titleController = TextEditingController();

    bool disciplineSelected = true;
    bool typeSelected = true;

    String? disciplineVal;
    String? typeVal;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  course.courseName,
                  style: const TextStyle(fontSize: 18),
                ),
                height5(),
                Text(course.courseCode),
                height10(),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text("Select section"),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              !disciplineSelected ? Colors.red : Colors.black26,
                        ),
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: disciplineVal,
                      items: getItems(),
                      onChanged: (val) {
                        setState(() {
                          disciplineVal = val;
                          disciplineSelected = true;
                        });
                      }),
                ),
                height10(),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      hint: const Text("Select type"),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: !typeSelected ? Colors.red : Colors.black26,
                        ),
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      value: typeVal,
                      items: const [
                        DropdownMenuItem(
                          value: "quiz",
                          child: Text("Quiz"),
                        ),
                        DropdownMenuItem(
                          value: "assignment",
                          child: Text("Assignment"),
                        ),
                        DropdownMenuItem(
                          value: "mid",
                          child: Text("Mid"),
                        ),
                        DropdownMenuItem(
                          value: "final",
                          child: Text("Final"),
                        )
                      ],
                      onChanged: (val) {
                        setState(() {
                          typeVal = val;
                          typeSelected = true;
                        });
                      }),
                ),
                height10(),
                TextField(
                  enabled: typeVal != "mid" && typeVal != "final",
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                height10(),
                TextField(
                  controller: totalController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "Total Marks",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                height10(),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      if (disciplineVal == null) {
                        setState(() {
                          disciplineSelected = false;
                        });
                      }
                      if (typeVal == null) {
                        setState(() {
                          typeSelected = false;
                        });
                      } else {
                        Navigator.pop(context);
                        var splitted = disciplineVal!.split('-');
                        int id = int.parse(splitted[0]);

                        CourseSection courseSection = cList!
                            .where(
                                (c) => c.section == splitted[1] && c.id == id)
                            .first;
                        navigate(
                            context,
                            StudentEvaluationScreen(
                              courseSection: courseSection,
                              type: typeVal!,
                              total: double.parse(totalController.text),
                              title: titleController.text,
                            ));
                      }
                    },
                    child: const Text("Mark Evaluation"))
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Evaluation"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Text(
                course.courseName,
                style: header1TextStyle,
              ),
              height5(),
              Text(course.courseCode),
              height20(),
              // AppButton(
              //     child: Text(
              //       "View Evaluation",
              //       style: textColorStyle,
              //     ),
              //     onTap: () {}),
              // height10(),
              AppButton(
                  child: Text(
                    "Mark Evaluation",
                    style: textColorStyle,
                  ),
                  onTap: () {
                    selectSectionSemesterDialog(context);
                  }),
            ])));
  }
}
