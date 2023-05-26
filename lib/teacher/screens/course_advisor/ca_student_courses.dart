import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/teacher/models/core/course.dart';
import 'package:student_portal/teacher/models/core/course_advisor.dart';
import 'package:student_portal/teacher/screens/course_advisor/advice_dialog_box.dart';

class CAStudentCourses extends StatelessWidget {
  const CAStudentCourses(
      {super.key,
      required this.student,
      required this.section,
      required this.id});
  final SList student;
  final String section;
  final id;

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text("Course Name",
                  style:
                      header2TextStyle.copyWith(fontWeight: FontWeight.bold))),
          width20(),
          Expanded(
              flex: 1,
              child: Text("Course Code",
                  style:
                      header2TextStyle.copyWith(fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Advice Student"),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AdviceDialogBox(
                    regNo: student.regNo!,
                    id: id,
                  ));
        },
      ),
      appBar: AppBar(
        title: const Text("Courses Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("Name", style: boldTextStyle)),
                      Expanded(child: Text(student.name!)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Reg No", style: boldTextStyle)),
                      Expanded(child: Text(student.regNo!)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Section", style: boldTextStyle)),
                      Expanded(child: Text(section)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("CGPA", style: boldTextStyle)),
                      Expanded(child: Text(student.cgpa!.toString())),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1.2,
            ),
            height10(),
            Column(
              children: [
                _buildCoursesTable("Regular Courses", student.regularcourses!),
                _buildCoursesTable("Failed Courses", student.failedcourses!),
                _buildCoursesTable(
                    "Remaining Courses", student.remainingcourses!),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesTable(String title, List<Course?> courses) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            height5(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(title, style: boldTextStyle),
            ),
            const Divider(height: 1.2, color: primaryColor),
            courses.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text("No ${title.toLowerCase()}",
                        style: header3TextStyle),
                  )
                : Column(
                    children: [
                      _buildTableHeader(),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      courses[index]!.courseName,
                                      style: header2TextStyle,
                                    )),
                                width20(),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      courses[index]!.courseCode,
                                      style: header2TextStyle,
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
            height10(),
          ],
        ),
      ),
    );
  }
}
