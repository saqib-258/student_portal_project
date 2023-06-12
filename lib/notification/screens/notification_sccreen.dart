import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/notification/model/notification.dart';
import 'package:student_portal/notification/provider/notification_provider.dart';
import 'package:student_portal/notification/screens/no_notification.dart';
import 'package:student_portal/notification/service/notification_api.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/screens/finance/fine/fine_screen.dart';
import 'package:student_portal/student/screens/noticeboard/noticeboard_screen.dart';
import 'package:student_portal/student/screens/teacher_evaluation/assessment_screen.dart';
import 'package:student_portal/teacher/screens/attendance/contest_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Consumer<NotificationProvider>(builder: (context, provider, _) {
        if (provider.notifications == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.notifications!.isEmpty) {
          return const NoNotification();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: provider.notifications!.length,
          itemBuilder: (context, index) {
            return NotificationCard(model: provider.notifications![index]);
          },
        );
      }),
    );
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, required this.model});
  final NotificationModel model;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: GestureDetector(
        onTap: () {
          NotificationApi.seenNotification(widget.model.id);

          setState(() {
            widget.model.status = true;
          });
          if (widget.model.type == "fine") {
            navigate(context, const FineScreen());
          } else if (widget.model.type == "notice_board") {
            navigate(context, const NoticeboardScreen());
          } else if (widget.model.type == "teacher_evaluation") {
            navigate(context, const AssessmentScreen());
          } else if (widget.model.type == "teacher_contest") {
            navigate(context, const ContestScreen());
          }
        },
        child: Card(
          elevation: 0,
          color: !widget.model.status
              ? Colors.lightBlue.withOpacity(0.2)
              : backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.circle_notifications,
                      size: 34,
                    ),
                    width10(),
                    Expanded(
                      child: Text(
                        widget.model.detail,
                      ),
                    ),
                  ],
                ),
                height10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.model.dateTime,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    width10(),
                    Visibility(
                        visible: !widget.model.status,
                        child: const Icon(
                          Icons.circle,
                          color: primaryColor,
                          size: 12,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
