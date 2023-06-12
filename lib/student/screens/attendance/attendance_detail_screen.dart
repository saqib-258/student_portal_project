import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';
import 'package:student_portal/student/screens/attendance/attendance_card.dart';
import 'package:student_portal/student/screens/attendance/attendance_progress_indicator.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final AttendanceModel item;

  const AttendanceDetailScreen({super.key, required this.item});

  @override
  State<AttendanceDetailScreen> createState() => _AttendanceDataTableState();
}

class _AttendanceDataTableState extends State<AttendanceDetailScreen> {
  String type = "all";
  List<AttendanceDetailModel> aList = [];

  getList() {
    if (type == "all") {
      aList = widget.item.detail;
    } else {
      aList =
          widget.item.detail.where((element) => element.type == type).toList();
    }
    aList.sort(
      (a, b) => DateTime.parse(a.date.split(',')[0])
          .compareTo(DateTime.parse(b.date.split(',')[0])),
    );
    aList = aList.reversed.toList();
    setState(() {});
  }

  @override
  void initState() {
    getIt<AttendanceProvider>().getAbsentList(widget.item.enrollmentId);
    getList();
    super.initState();
  }

  onLongPress(BuildContext context, int attendanceId) {
    final provider = getIt<AttendanceProvider>();
    if (provider.absentIds == null) {
      showToast("Please try again");
    } else if (!provider.absentIds!.contains(attendanceId)) {
      showToast("You cannot contest this attendance");
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AppConfirmDialog(
              title: "Do you really want to contest?",
              onConfirm: () async {
                bool? isDone = await provider.contestAttendace(attendanceId,
                    widget.item.courseCode, widget.item.enrollmentId);

                if (isDone != null) {
                  showToast("Submitted successfully");
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: Column(
        children: [
          AttendanceDetailHeader(item: widget.item),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                    title: Text(
                      "All",
                      style: header2TextStyle,
                    ),
                    value: "all",
                    groupValue: type,
                    onChanged: (val) {
                      type = val!;
                      getList();
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: Text(
                      "Class",
                      style: header2TextStyle,
                    ),
                    value: "class",
                    groupValue: type,
                    onChanged: (val) {
                      type = val!;
                      getList();
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: Text(
                      "Lab",
                      style: header2TextStyle,
                    ),
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
                          return GestureDetector(
                              onLongPress: () =>
                                  onLongPress(context, model.aid),
                              child: AttendanceCard(model: model));
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
