import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/screens/attendance/attendance_card.dart';
import 'package:student_portal/student/screens/attendance/attendance_contest_screen.dart';
import 'package:student_portal/student/screens/attendance/attendance_progress_indicator.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final AttendanceModel item;

  const AttendanceDetailScreen({super.key, required this.item});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDataTableState();
}

class _AttendanceDataTableState extends State<AttendanceDetailScreen> {
  String type = "class";
  List<AttendanceDetailModel> aList = [];

  getList() {
    aList =
        widget.item.detail.where((element) => element.type == type).toList();
    setState(() {});
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Attendance"),
        actions: [
          GestureDetector(
            child: PopupMenuButton<String>(
                itemBuilder: (_) => const <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        value: 'contest',
                        child: Text('Contest'),
                      ),
                    ],
                onSelected: (String value) {
                  if (value == 'contest') {
                    List<AttendanceContest> absentsList = widget.item.detail
                        .where(
                          (element) => element.status == "A",
                        )
                        .map((e) => AttendanceContest(
                            type: e.type,
                            aid: e.aid,
                            isChecked: false,
                            date: e.date,
                            status: e.status))
                        .toList();

                    navigate(
                        context,
                        AttendanceContestScreen(
                          courseCode: widget.item.courseCode,
                          eid: widget.item.enrollmentId,
                          aList: absentsList,
                        ));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    FontAwesomeIcons.ellipsisVertical,
                    color: textColor,
                    size: 18,
                  ),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          AttendanceDetailHeader(item: widget.item),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                    title: const Text("Class"),
                    value: "class",
                    groupValue: type,
                    onChanged: (val) {
                      type = val!;
                      getList();
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: const Text("Lab"),
                    value: "lab",
                    groupValue: type,
                    onChanged: (val) {
                      type = val!;
                      getList();
                    }),
              )
            ],
          ),
          Expanded(
            child: ColoredBox(
              color: textColor,
              child: Column(
                children: [
                  height10(),
                  Row(
                    children: [
                      const Spacer(
                        flex: 5,
                      ),
                      Text(
                        "Date",
                        style: boldTextStyle,
                      ),
                      const Spacer(
                        flex: 8,
                      ),
                      Text(
                        "Status",
                        style: boldTextStyle,
                      ),
                      const Spacer(
                        flex: 3,
                      )
                    ],
                  ),
                  height10(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: aList.length,
                        itemBuilder: (context, index) {
                          AttendanceDetailModel model = aList[index];
                          return AttendanceCard(model: model);
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AttendanceDetailHeader extends StatelessWidget {
  const AttendanceDetailHeader({super.key, required this.item});
  final AttendanceModel item;
  @override
  Widget build(BuildContext context) {
    int total = item.absents + item.presents;
    double percentage;
    if (total == 0) {
      percentage = 1.0;
    } else {
      percentage = item.presents / total;
    }
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: ColoredBox(
        color: textColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                item.courseName,
                style: mediumTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AttendanceProgressIndicator(percentage: percentage),
                Column(
                  children: [
                    Card(
                      color: primaryColor,
                      shape: const StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 90,
                          child: Center(
                            child: Text(
                              "Prsents  ${item.presents}",
                              style:
                                  header2TextStyle.copyWith(color: textColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    height10(),
                    Card(
                      color: secondaryCardColor,
                      shape: const StadiumBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 90,
                          child: Center(
                            child: Text(
                              "Absents  ${item.absents}",
                              style:
                                  header2TextStyle.copyWith(color: textColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
