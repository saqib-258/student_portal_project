import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/student/models/core/notification.dart';
import 'package:student_portal/student/screens/notification/no_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationModel> nList;
  @override
  void initState() {
    nList = NotificationModel.notificationList
        .where((element) => !element.isSeen)
        .toList();

    NotificationModel.notificationList =
        NotificationModel.notificationList.map((e) {
      e.isSeen = true;
      return e;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Notification")),
      body: nList.isEmpty
          ? const NoNotification()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: nList.length,
                itemBuilder: (context, index) {
                  return NotificationCard(model: nList[index]);
                },
              ),
            ),
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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.author,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              height5(),
              widget.model.title != ""
                  ? Text(
                      widget.model.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )
                  : const SizedBox.shrink(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    widget.model.description,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ),
              ),
              height10(),
              Text(
                widget.model.dateTime.toString().split(' ')[0],
                style: const TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
