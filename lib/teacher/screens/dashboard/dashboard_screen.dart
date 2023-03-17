import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/shared/utils/images.dart';
import 'package:student_portal/student/screens/evaluation/exam_result_screen.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/screens/attendance/contest_screen.dart';
import 'package:student_portal/teacher/screens/dashboard/course_card.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});
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
                        const Text(
                          "Saeed Watto",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Text(
                          "saeed211@gmail.com",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
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
                onTap: () {},
                leading: const Icon(FontAwesomeIcons.book),
                title: const Text("Allocated Courses"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const ContestScreen());
                },
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text("Contests"),
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
                  height: 32,
                  width: 32,
                ),
              ),
            );
          }),
          title: const Text("Dashboard"),
        ),
        drawer: buildDrawer(context),
        body: Consumer<CourseSectionProvider>(
            builder: (context, provider, child) {
          if (provider.courses == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: provider.courses!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CourseCard(course: provider.courses![index]),
                  );
                });
          }
        }));
  }
}
