import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/attendance.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.model,
  });
  final AttendanceDetailModel model;

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
              ]),
        ),
      ),
    );
  }
}
