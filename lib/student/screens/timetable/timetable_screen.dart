import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/time_table.dart';
import 'package:student_portal/student/providers/time_table_provider.dart';
import 'package:student_portal/shared/utils/common.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen>
    with AfterLayoutMixin<TimetableScreen> {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final provider = getIt<TimeTableProvider>();
    await provider.getTimeTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Timetable"),
        ),
        body: Consumer<TimeTableProvider>(
            builder: (context, timeTableProvider, _) {
          return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: timeTableProvider.timeTableList == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: primaryColor,
                    ))
                  : ListView.builder(
                      itemCount: timeTableProvider.timeTableList!.length,
                      itemBuilder: (context, index) {
                        return AttendanceCard(
                            model:
                                timeTableProvider.timeTableList![index].detail,
                            day: timeTableProvider.timeTableList![index].day);
                      },
                    ));
        }));
  }
}

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.model, required this.day});
  final List<TimeTableDetail> model;
  final String day;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: getWeekDay(DateTime.now()) == day ? secondaryColor : textColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                day,
                style:
                    boldTextStyle.copyWith(fontSize: 16, color: primaryColor),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1.1,
              color: primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Course",
                        style: boldTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Time",
                        style: boldTextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "Venue",
                        style: boldTextStyle,
                      ),
                    ],
                  ),
                  height10(),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: model.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(
                                model[index].courseName.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                          width20(),
                          Expanded(
                              flex: 10,
                              child: Text(
                                model[index].time.toString(),
                                style: header3TextStyle,
                              )),
                          width20(),
                          Expanded(
                              flex: 3,
                              child: Text(
                                model[index].venue.toString(),
                                style: header3TextStyle,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
