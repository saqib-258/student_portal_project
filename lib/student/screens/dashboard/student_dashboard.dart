import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/shared/common_widgets/background_decoration.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/grid_view_items.dart';
import 'package:student_portal/student/providers/enrollment_provider.dart';
import 'package:student_portal/student/screens/course_advisor/advises.dart';
import 'package:student_portal/student/screens/enrollment/enrollment_screen.dart';
import 'package:student_portal/student/screens/noticeboard/noticeboard_screen.dart';
import 'package:student_portal/student/screens/peer_evaluation/peer_evaluation_teachers_screen.dart';
import 'package:student_portal/student/screens/teacher_evaluation/assessment_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/shared/utils/images.dart';
import 'package:student_portal/student/screens/dashboard/custom_app_bar.dart';
import 'package:student_portal/student/screens/datesheet/datesheet_screen.dart';
import 'package:student_portal/student/screens/evaluation/exam_result_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(),
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final enrollmentProvider = getIt<EnrollmentProvider>();
    String? status = await enrollmentProvider.getEnrollmentStatus();
    if (status == "not-enrolled") {
      // ignore: use_build_context_synchronously
      navigateAndOffAll(context, const EnrollmentScreen());
    }
  }

  Widget _buildDivider(BuildContext context) {
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
                    child: Consumer<UserDetailProvider>(
                        builder: (context, provider, _) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.userDetail!.profilePhoto == null
                                ? const CircleAvatar(
                                    backgroundColor: Colors.white38,
                                    radius: 32,
                                    backgroundImage: AssetImage(
                                      "assets/images/avatar-icon.png",
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white38,
                                    radius: 32,
                                    backgroundImage: NetworkImage(getFileUrl(
                                        "ProfileImages",
                                        provider.userDetail!.profilePhoto!))),
                            height10(),
                            Text(
                              provider.userDetail == null ||
                                      provider.userDetail!.name == null
                                  ? ""
                                  : provider.userDetail!.name!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              provider.userDetail == null
                                  ? ""
                                  : provider.userDetail!.username,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ]);
                    })),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(FontAwesomeIcons.book),
              title: const Text("Courses"),
            ),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const ExamResultScreen());
                },
                leading: const Icon(FontAwesomeIcons.fileLines),
                title: const Text("Exam Result"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const NoticeboardScreen());
                },
                leading: Image.asset(
                  noticeBoardIcon,
                  width: 28,
                ),
                title: const Text("Notice Board"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const DatesheetScreen());
                },
                leading: Image.asset(
                  datesheetIcon,
                  width: 32,
                ),
                title: const Text("Date Sheet"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const AssessmentScreen());
                },
                leading: Image.asset(
                  assessmentIcon,
                  width: 28,
                ),
                title: const Text("Teacher Evaluation"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const PeerEvaluationCourseScreen());
                },
                leading: Image.asset(
                  peerEvaluationImage,
                  width: 28,
                ),
                title: const Text("Teacher Ratings"),
              );
            }),
            buildDivider(),
            Builder(builder: (context) {
              return ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  navigate(context, const AdvisesScreen());
                },
                leading: const Icon(Icons.person_3),
                title: const Text("Advisor"),
              );
            }),
            const Spacer(),
            buildDivider(),
            ListTile(
              onTap: () {
                getIt<AuthProvider>().logoutUser(context);
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
    return BackgroundDecoration(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(),
        drawer: _buildDivider(context),
        body: Container(
          decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
                itemCount: studentDashboarGridItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemBuilder: (context, index) {
                  GridItem item = studentDashboarGridItems[index];
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
                          Text(item.title),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
