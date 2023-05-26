import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course_advisor.dart';
import 'package:student_portal/teacher/screens/course_advisor/ca_student_courses.dart';

class CourseAdvisorStudentScreen extends StatefulWidget {
  const CourseAdvisorStudentScreen({super.key, required this.model});
  final CourseAdvisor model;

  @override
  State<CourseAdvisorStudentScreen> createState() =>
      _CourseAdvisorStudentScreenState();
}

class _CourseAdvisorStudentScreenState
    extends State<CourseAdvisorStudentScreen> {
  List<SList?>? studentsList;
  @override
  void initState() {
    studentsList = widget.model.sList!;
    super.initState();
  }

  String _selectedVal = "all";
  _onFilterChanged(val) {
    _selectedVal = val;
    if (val == "2.5") {
      studentsList =
          widget.model.sList!.where((element) => element!.cgpa! < 2.5).toList();
    } else if (val == "3.0") {
      studentsList =
          widget.model.sList!.where((element) => element!.cgpa! < 3.0).toList();
    } else if (val == "all") {
      studentsList = widget.model.sList!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students CGPA"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BS${widget.model.program}-${widget.model.semester}${widget.model.section}',
                  style: const TextStyle(fontSize: 17),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      alignment: Alignment.center,
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onChanged: _onFilterChanged,
                      value: _selectedVal,
                      items: const [
                        DropdownMenuItem(value: "all", child: Text("All")),
                        DropdownMenuItem(
                            value: "2.5", child: Text("Less than 2.5")),
                        DropdownMenuItem(
                            value: "3.0", child: Text("Less than 3.0")),
                      ]),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: studentsList!.length,
              itemBuilder: (context, index) {
                return StudentDetailCard(
                    onTap: () {
                      navigate(
                          context,
                          CAStudentCourses(
                              id: widget.model.id,
                              student: studentsList![index]!,
                              section:
                                  'BS${widget.model.program}-${widget.model.semester}${widget.model.section}'));
                    },
                    showSection: false,
                    model: studentsList![index],
                    trailing: Text(studentsList![index]!.cgpa.toString()));
              },
            ),
          )
        ],
      ),
    );
  }
}
