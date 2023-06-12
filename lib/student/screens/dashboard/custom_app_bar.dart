import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';

import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/notification_icon_stack.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/shared/utils/common.dart';

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
                    Consumer<UserDetailProvider>(
                        builder: (context, provider, _) {
                      return SizedBox(
                        child: user.userDetail!.profilePhoto == null
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/avatar-icon.png"),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(getFileUrl(
                                    "ProfileImages",
                                    user.userDetail!.profilePhoto!)),
                              ),
                      );
                    })
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
