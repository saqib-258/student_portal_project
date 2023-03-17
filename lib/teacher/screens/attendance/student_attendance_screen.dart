import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key, required this.courseSection});
  final CourseSection courseSection;

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen>
    with AfterLayoutMixin {
  final provider = getIt<StudentAttendanceProvider>();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    provider.getStudents(widget.courseSection.section, widget.courseSection.id);
    provider.changeDate(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate!,
        firstDate: provider.selectedDate!.subtract(const Duration(days: 30)),
        lastDate: provider.selectedDate!.add(const Duration(days: 30)));
    if (picked != null && picked != provider.selectedDate) {
      provider.changeDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
        ),
        body: Consumer<StudentAttendanceProvider>(
          builder: (context, provider, _) {
            if (provider.sList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.courseSection.courseName,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: mediumTextStyle.copyWith(
                                      fontWeight: FontWeight.w600),
                                ),
                                height10(),
                                Text(
                                  'BS${widget.courseSection.program}-${widget.courseSection.semester}${widget.courseSection.section}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            TextButton.icon(
                                style: TextButton.styleFrom(
                                    iconColor: Colors.black54,
                                    side: const BorderSide(
                                        color: Colors.black54)),
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(Icons.date_range),
                                label: Text(
                                    provider.selectedDate
                                        .toString()
                                        .split(' ')[0],
                                    style: header2TextStyle.copyWith(
                                        color: Colors.black54))),
                            Text(getWeekDay(provider.selectedDate!)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0, thickness: 1.6),
                  Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Class"),
                        value: "class",
                        onChanged: (val) {
                          provider.changeType(val!);
                        },
                        groupValue: provider.type,
                      )),
                      Expanded(
                          child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Lab"),
                        value: "lab",
                        onChanged: (val) {
                          provider.changeType(val!);
                        },
                        groupValue: provider.type,
                      )),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: provider.sList!.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text(provider.sList![index].regNo)),
                            Expanded(
                                flex: 5,
                                child: Text(provider.sList![index].name)),
                            Expanded(
                              flex: 2,
                              child: Checkbox(
                                value: provider.sList![index].status == 'P',
                                onChanged: (val) {
                                  provider.onMarkClick(val!, index);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: AppButton(
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () async {
                          bool? isDone = await provider.markAttendace();
                          if (isDone != null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text("Submitted successfully")));
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }),
                  )
                ],
              );
            }
          },
        ));
  }
}
