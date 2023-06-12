import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/notification/provider/notification_provider.dart';
import 'package:student_portal/notification/screens/notification_sccreen.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/utils/common.dart';

class NotificationIconStack extends StatefulWidget {
  const NotificationIconStack({super.key});

  @override
  State<NotificationIconStack> createState() => _NotificationIconStackState();
}

class _NotificationIconStackState extends State<NotificationIconStack> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          IconButton(
              splashRadius: 24,
              onPressed: () async {
                await navigateTo(context, const NotificationScreen());
                setState(() {});
              },
              icon: const Icon(
                FontAwesomeIcons.solidBell,
                color: textColor,
              )),
          Consumer<NotificationProvider>(builder: (context, provider, _) {
            if (provider.notifications == null) {
              return const SizedBox.shrink();
            }
            return Visibility(
              visible: provider.notifications!
                  .where((element) => !element.status)
                  .isNotEmpty,
              child: const Positioned(
                bottom: 12,
                right: 8,
                child: Icon(
                  FontAwesomeIcons.solidCircle,
                  color: Colors.red,
                  size: 12,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
