import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/teacher/models/services/student_attendance_api.dart';

class ContestSetting extends StatefulWidget {
  const ContestSetting({super.key});

  @override
  State<ContestSetting> createState() => _ContestSettingState();
}

class _ContestSettingState extends State<ContestSetting> {
  int? days;
  int? initialDays;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    var data = await StudentAttendanceApi.getContestSetting();
    data.fold((l) => null, (r) {
      initialDays = r;
      days = r;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contest Setting"),
      ),
      body: Column(
        children: [
          height20(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              "Days",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    splashRadius: 20,
                    onPressed: days == null
                        ? null
                        : () {
                            if (days! > 0) {
                              days = days! - 1;
                              setState(() {});
                            }
                          },
                    icon: const Icon(
                      Icons.remove,
                      size: 30,
                    )),
                Text(
                  days == null ? "0" : days.toString(),
                  style: mediumTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: initialDays == days ? null : Colors.red),
                ),
                IconButton(
                    splashRadius: 20,
                    onPressed: days == null
                        ? null
                        : () {
                            days = days! + 1;
                            setState(() {});
                          },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    )),
              ],
            )
          ]),
          height30(),
          ElevatedButton(
              onPressed: days == initialDays
                  ? null
                  : () async {
                      if (days != null) {
                        var data =
                            await StudentAttendanceApi.setContestSetting(days!);
                        data.fold((l) {
                          showToast("Something went wrong");
                        }, (r) {
                          if (r == null) {
                            showToast("Something went wrong");
                          } else {
                            showToast("Setting saved successfully");
                            initialDays = days;
                          }
                        });
                      }
                    },
              child: const Text("Save"))
        ],
      ),
    );
  }
}
