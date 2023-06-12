import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

import 'package:student_portal/shared/utils/images.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Spacer(
          flex: 3,
        ),
        Container(
          padding: const EdgeInsets.all(32),
          height: 250,
          width: 250,
          decoration:
              const BoxDecoration(color: textColor, shape: BoxShape.circle),
          child: Image.asset(noNotificationImage),
        ),
        const Spacer(),
        Text(
          "No Notification yet",
          style: header1TextStyle.copyWith(letterSpacing: 1.8),
        ),
        const Spacer(flex: 4),
      ]),
    );
  }
}
