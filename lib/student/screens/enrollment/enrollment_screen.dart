import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/enrollment_courses.dart';
import 'package:student_portal/student/providers/enrollment_provider.dart';
import 'package:student_portal/student/screens/dashboard/student_dashboard.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({super.key});

  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen>
    with AfterLayoutMixin {
  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    final provider = getIt<EnrollmentProvider>();
    provider.getEnrollmentCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enrollment"),
        actions: [
          IconButton(
              onPressed: () {
                getIt<AuthProvider>().logoutUser(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<EnrollmentProvider>(builder: (context, provider, _) {
        if (provider.cList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "Course",
                              style: boldTextStyle,
                            ),
                            const Spacer(
                              flex: 5,
                            ),
                            Text(
                              "Credit hours",
                              style: boldTextStyle,
                            ),
                            const Spacer(),
                            Text(
                              "Status",
                              style: boldTextStyle,
                            )
                          ],
                        ),
                      ),
                      const Divider(thickness: 1.2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Regular courses",
                          style: header3TextStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: provider.cList!.regularCourses.length,
                            itemBuilder: (context, index) {
                              RegularCourses r =
                                  provider.cList!.regularCourses[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: EnrollmentCourseRow(
                                      courseCode: r.courseCode,
                                      courseName: r.courseName,
                                      creditHours: r.creditHours,
                                      isSelected: true),
                                ),
                              );
                            }),
                      ),
                      height5(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Failed / Remaining courses",
                          style: header3TextStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: provider.cList!.failedCourses.length,
                            itemBuilder: (context, index) {
                              FailedCourses r =
                                  provider.cList!.failedCourses[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EnrollmentCourseRow(
                                        courseCode: r.courseCode,
                                        courseName: r.courseName,
                                        creditHours: r.creditHours,
                                        isSelected: r.isSelected,
                                        onValueChanged: r.sections.isEmpty
                                            ? null
                                            : (val) {
                                                r.isSelected = val;
                                                provider.notify();
                                              },
                                      ),
                                      height10(),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                            hint: const Text("Select section"),
                                            buttonDecoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            value: r.selectedVal,
                                            items: r.sections
                                                .map((e) => DropdownMenuItem(
                                                    value:
                                                        '${e.id}-${e.section}-${e.program}',
                                                    child: Text(
                                                        '${e.program}-${e.semester}${e.section}')))
                                                .toList(),
                                            onChanged: r.isSelected
                                                ? (val) {
                                                    r.selectedVal =
                                                        val as String?;
                                                    provider.notify();
                                                  }
                                                : null),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppButton(
                      child: Text(
                        "Enroll",
                        style: textColorStyle,
                      ),
                      onTap: () async {
                        bool? isDone = await provider.enrollCourses();
                        if (isDone != null) {
                          showToast("Enrolled Courses Successfully");
                          // ignore: use_build_context_synchronously
                          navigateAndOffAll(context, const StudentDashboard());
                        }
                      }),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class EnrollmentCourseRow extends StatelessWidget {
  const EnrollmentCourseRow(
      {super.key,
      required this.courseCode,
      required this.courseName,
      required this.creditHours,
      required this.isSelected,
      this.onValueChanged});
  final String courseName;
  final String courseCode;
  final int creditHours;
  final bool isSelected;
  final Function(bool)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  courseName,
                ),
              ),
              Text(
                courseCode,
                style: header3TextStyle,
              ),
            ],
          ),
        ),
        Expanded(flex: 2, child: Text(creditHours.toString())),
        Expanded(
            child: Checkbox(
                value: isSelected,
                onChanged: onValueChanged == null
                    ? null
                    : (val) {
                        onValueChanged!(val!);
                      }))
      ],
    );
  }
}
