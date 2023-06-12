import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/notification.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/screens/notification/notification_sccreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                    "assets/images/menu_icon.svg",
                    color: textColor,
                    height: 32,
                    width: 32,
                  ),
                ),
                Row(
                  children: [
                    const NotificationIconStack(),
                    width10(),
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/avatar-icon.png"),
                    ),
                  ],
                ),
              ],
            ),
            height10(),
            Text("Dashboard",
                style: header1TextStyle.copyWith(color: textColor)),
            Consumer<UserDetailProvider>(builder: (context, provider, _) {
              return Text(
                "Welcome, ${user.userDetail == null || user.userDetail!.name == null ? "" : user.userDetail!.name}",
                style: const TextStyle(color: textColor),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 160);
}

class NotificationIconStack extends StatefulWidget {
  const NotificationIconStack({super.key});

  @override
  State<NotificationIconStack> createState() => _NotificationIconStackState();
}

class _NotificationIconStackState extends State<NotificationIconStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        NotificationModel.notificationList
                .where((element) => !element.isSeen)
                .isNotEmpty
            ? const Positioned(
                bottom: 12,
                right: 8,
                child: Icon(
                  FontAwesomeIcons.solidCircle,
                  color: Colors.red,
                  size: 12,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
