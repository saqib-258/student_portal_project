import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';

class AttendanceContestScreen extends StatefulWidget {
  const AttendanceContestScreen(
      {super.key,
      required this.aList,
      required this.courseCode,
      required this.eid});
  final List<AttendanceContest> aList;
  final String courseCode;
  final int eid;
  @override
  State<AttendanceContestScreen> createState() =>
      _AttendanceContestScreenState();
}

class _AttendanceContestScreenState extends State<AttendanceContestScreen> {
  @override
  void initState() {
    super.initState();
  }

  showContestConformDialog(BuildContext context) {
    if (widget.aList.where((element) => element.isChecked).isEmpty) {
      showToast("No attendance selected");
      return;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Do you really want to contest?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      final provider = getIt<AttendanceProvider>();
                      bool? isDone = await provider.contestAttendace(
                          widget.aList, widget.courseCode, widget.eid);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      if (isDone != null) {
                        showToast("Submitted successfully");
                      }
                    },
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showContestConformDialog(context);
              },
              icon: const Icon(Icons.done),
            ),
          ],
          title: const Text("Select attendance")),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
            itemCount: widget.aList.length,
            itemBuilder: (context, index) {
              return AttendanceContestCard(
                model: widget.aList[index],
                onCheckChange: () {
                  widget.aList[index].isChecked =
                      !(widget.aList[index].isChecked);
                  setState(() {});
                },
              );
            }),
      ),
    );
  }
}

class AttendanceContestCard extends StatelessWidget {
  const AttendanceContestCard(
      {super.key, required this.model, required this.onCheckChange});
  final AttendanceContest model;
  final VoidCallback onCheckChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: model.status == "P" ? primaryColor : secondaryCardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.date,
                      style: textColorStyle,
                    ),
                    Text(
                      getWeekDay(DateTime.parse(model.date)),
                      style: textColorStyle,
                    ),
                  ],
                ),
                Text(
                  model.status,
                  style: boldTextStyle.copyWith(color: textColor),
                ),
                Text(
                  model.type,
                  style: boldTextStyle.copyWith(color: textColor),
                ),
                Checkbox(
                    side: const BorderSide(color: textColor, width: 2),
                    value: model.isChecked,
                    onChanged: (val) {
                      onCheckChange();
                    })
              ]),
        ),
      ),
    );
  }
}
