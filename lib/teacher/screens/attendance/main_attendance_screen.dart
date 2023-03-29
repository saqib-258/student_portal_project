import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';
import 'package:student_portal/teacher/screens/attendance/student_attendance_screen.dart';

class MainAttendanceScreen extends StatelessWidget {
  MainAttendanceScreen({super.key, required this.course});
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
    bool isSelected = true;
    String? selectedVal;

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
                      hint: const Text("Select discipline"),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: !isSelected ? Colors.red : Colors.black26,
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
                          isSelected = true;
                        });
                      }),
                ),
                height10(),
                Consumer<StudentAttendanceProvider>(
                    builder: (context, provider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "class",
                            onChanged: (val) {
                              provider.changeType(val!);
                            },
                            groupValue: provider.type,
                          ),
                          width10(),
                          const Text("Class"),
                        ],
                      ),
                      width20(),
                      Row(
                        children: [
                          Radio(
                            value: "lab",
                            onChanged: (val) {
                              provider.changeType(val!);
                            },
                            groupValue: provider.type,
                          ),
                          width10(),
                          const Text("Lab"),
                        ],
                      ),
                    ],
                  );
                }),
                height20(),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      if (selectedVal == null) {
                        setState(() {
                          isSelected = false;
                        });
                      } else {
                        Navigator.pop(context);
                        var splitted = selectedVal!.split('-');
                        int id = int.parse(splitted[0]);

                        CourseSection courseSection = cList!
                            .where(
                                (c) => c.section == splitted[1] && c.id == id)
                            .first;
                        navigate(
                            context,
                            StudentAttendanceScreen(
                                courseSection: courseSection));
                      }
                    },
                    child: const Text("Mark Attendance"))
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
          title: const Text("Attendance"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                course.courseName,
                style: header1TextStyle,
              ),
              height5(),
              Text(course.courseCode),
              height20(),
              AppButton(
                  child: Text(
                    "View Attendance",
                    style: textColorStyle,
                  ),
                  onTap: () {}),
              height10(),
              AppButton(
                  child: Text(
                    "Mark Attendance",
                    style: textColorStyle,
                  ),
                  onTap: () {
                    selectSectionSemesterDialog(context);
                  }),
            ],
          ),
        ));
  }
}
