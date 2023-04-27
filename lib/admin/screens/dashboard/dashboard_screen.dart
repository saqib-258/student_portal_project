import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/screens/financial_assistance/student_financial_assistnace_request_screens.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/shared/utils/grid_view_items.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(),
    );
  }

  buildDrawer(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white38,
                          radius: 32,
                          backgroundImage: AssetImage(
                            "assets/images/avatar-icon.png",
                          ),
                        ),
                        height10(),
                        Consumer<UserDetailProvider>(
                            builder: (context, provider, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.userDetail == null
                                    ? ""
                                    : provider.userDetail!.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                provider.userDetail == null
                                    ? ""
                                    : provider.userDetail!.username,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          );
                        }),
                      ]),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
            ),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  navigate(
                      context, const StudentFinancialAssistanceRequestScreen());
                },
                leading: const Icon(FontAwesomeIcons.circleDollarToSlot),
                title: const Text("Finanial Assistance Requests"),
              );
            }),
            const Spacer(),
            buildDivider(),
            ListTile(
              onTap: () {
                navigateAndOffAll(context, LoginScreen());
              },
              leading: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            height10()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () => {Scaffold.of(context).openDrawer()},
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/menu_icon.svg",
                  color: textColor,
                  height: 28,
                  width: 28,
                ),
              ),
            );
          }),
          title: const Text("Dashboard"),
        ),
        drawer: buildDrawer(context),
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
