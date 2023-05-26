import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/noticeboard.dart';
import 'package:student_portal/student/providers/noticeboard_provider.dart';

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NoticeboardScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<NoticeboardProvider>().getNoticeboardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Noticeboard")),
      body: Consumer<NoticeboardProvider>(builder: (context, provider, _) {
        if (provider.aList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.aList!.isEmpty) {
          return const Center(
            child: Text("No Noticeboard yet"),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: provider.aList!.length,
            itemBuilder: (context, index) {
              return NoticeboardCard(model: provider.aList![index]);
            },
          ),
        );
      }),
    );
  }
}

class NoticeboardCard extends StatefulWidget {
  const NoticeboardCard({super.key, required this.model});
  final Noticeboard model;

  @override
  State<NoticeboardCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NoticeboardCard> {
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
                widget.model.author!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              height5(),
              widget.model.title != ""
                  ? Text(
                      widget.model.title!,
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
                    widget.model.description!,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ),
              ),
              height20(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.model.date!,
                  style: const TextStyle(color: Colors.black54),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
