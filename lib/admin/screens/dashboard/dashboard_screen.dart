import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/shared/utils/grid_view_items.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: Center(
            child: SvgPicture.asset(
              "assets/images/menu_icon.svg",
              color: textColor,
              height: 32,
              width: 32,
            ),
          ),
          title: const Text("Dashboard"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
              itemCount: adminDashboardGridItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemBuilder: (context, index) {
                GridItem item = adminDashboardGridItems[index];
                return GestureDetector(
                  onTap: () {
                    navigate(context, item.screen);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item.image,
                          height: 56,
                          width: 56,
                        ),
                        height20(),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: header3TextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
