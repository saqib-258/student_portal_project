import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DateFormat format = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Timetable"),
        ),
        body: Consumer<TimeTableProvider>(
            builder: (context, timeTableProvider, _) {
          if (timeTableProvider.timeTableList == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }
          if (timeTableProvider.timeTableList!.isEmpty) {
            return const Text("No data found");
          }
          List<String> orderedDays = [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
          ];
          String today = getWeekDay(DateTime.now());
          orderedDays.remove(today);
          orderedDays.insert(0, today);
          timeTableProvider.timeTableList!.sort((a, b) {
            int indexA = orderedDays.indexOf(a.day);
            int indexB = orderedDays.indexOf(b.day);

            return indexA.compareTo(indexB);
          });
          return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                itemCount: timeTableProvider.timeTableList!.length,
                itemBuilder: (context, index) {
                  timeTableProvider.timeTableList![index].detail.sort(
                    (a, b) => format
                        .parse(a.time.split('-')[1])
                        .compareTo(format.parse(b.time.split('-')[1])),
                  );
                  return AttendanceCard(
                      model: timeTableProvider.timeTableList![index].detail,
                      day: timeTableProvider.timeTableList![index].day);
                },
              ));
        }));
  }
}

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({super.key, required this.model, required this.day});
  final List<TimeTableDetail> model;
  final String day;

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: getWeekDay(DateTime.now()) == widget.day
            ? secondaryColor
            : textColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.day,
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
                      width10(),
                      Expanded(
                        child: Text(
                          "Course",
                          style: boldTextStyle,
                        ),
                      ),
                      width20(),
                      Expanded(
                        child: Text(
                          "Time",
                          style: boldTextStyle,
                        ),
                      ),
                      width20(),
                      Expanded(
                        child: Text(
                          "Venue",
                          style: boldTextStyle,
                        ),
                      ),
                    ],
                  ),
                  height10(),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.model.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          width10(),
                          Expanded(
                              child: Text(
                            widget.model[index].courseName.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                          width20(),
                          Expanded(
                              child: Text(
                            widget.model[index].time.split(' ')[0].toString(),
                            style: header3TextStyle,
                          )),
                          width20(),
                          Expanded(
                              child: Text(
                            widget.model[index].venue.toString(),
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
