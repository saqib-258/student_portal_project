import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/providers/mark_result_provider.dart';

class StudentEvaluationScreen extends StatefulWidget {
  const StudentEvaluationScreen(
      {super.key,
      required this.courseSection,
      required this.total,
      required this.type,
      required this.title});
  final CourseSection courseSection;
  final String type, title;
  final double total;
  @override
  State<StudentEvaluationScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentEvaluationScreen>
    with AfterLayoutMixin {
  final provider = getIt<MarkResultProvider>();

  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    await provider.getStudents(
        widget.courseSection.section, widget.courseSection.id);
    for (int i = 0; i < provider.sList!.length; i++) {
      provider.sList![i].totalMarks = widget.total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Evaluation"),
        ),
        body: Consumer<MarkResultProvider>(
          builder: (context, provider, _) {
            if (provider.sList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, right: 16, left: 16, bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            widget.type.toUpperCase(),
                            style: boldTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    widget.title,
                    style: mediumTextStyle,
                  ),
                  Text(
                    'Total marks ${widget.total}',
                    style: mediumTextStyle,
                  ),
                  const Divider(height: 20, thickness: 1.6),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: provider.sList!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Text(provider.sList![index].regNo)),
                              Expanded(
                                  flex: 5,
                                  child: Text(provider.sList![index].name)),
                              Expanded(
                                  flex: 2,
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?\d{0,9}$')),
                                      RangeTextInputFormatter(
                                          min: 0,
                                          max: int.parse(widget.total
                                              .toString()
                                              .split('.')[0])),
                                    ],
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                        border: OutlineInputBorder()),
                                    onChanged: (val) {
                                      if (val == "") {
                                        return;
                                      }
                                      provider.sList![index].obtainedMarks =
                                          double.parse(val.toString());
                                    },
                                  )),
                            ],
                          ),
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
                          bool? isDone = await provider.markResult(
                              widget.title, widget.type);
                          if (isDone != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text("Submitted successfully")));
                          }
                          Navigator.pop(context);
                        }),
                  ),
                ],
              );
            }
          },
        ));
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int? min;
  final int? max;

  RangeTextInputFormatter({this.min, this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      final intValue = int.tryParse(newValue.text);
      if (intValue != null) {
        if (min != null && intValue < min!) {
          return oldValue;
        }
        if (max != null && intValue > max!) {
          return oldValue;
        }
      } else {
        return oldValue;
      }
    }
    return newValue;
  }
}
