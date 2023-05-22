import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';
import 'package:student_portal/student/screens/attendance/attendance_detail_screen.dart';
import 'package:student_portal/student/screens/attendance/attendance_progress_indicator.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AttendanceProvider>(builder: (context, provider, _) {
          if (provider.attendanceList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            itemCount: provider.attendanceList!.length,
            itemBuilder: (context, index) {
              AttendanceModel item = provider.attendanceList![index];
              int total = item.absents + item.presents;
              double percentage;
              if (total == 0) {
                percentage = 1;
              } else {
                percentage = item.presents / total;
              }
              return GestureDetector(
                onTap: () {
                  navigate(
                      context,
                      AttendanceDetailScreen(
                        item: item,
                      ));
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            item.courseName,
                            style: header2TextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AttendanceProgressIndicator(percentage: percentage)
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 220,
            ),
          );
        }),
      ),
    );
  }
}
