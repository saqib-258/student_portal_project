import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/notification_service.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/app_theme.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';
import 'package:student_portal/student/providers/date_sheet_provider.dart';
import 'package:student_portal/auth/provider/login_provider.dart';
import 'package:student_portal/student/providers/enrollment_provider.dart';
import 'package:student_portal/student/providers/evaluation_provider.dart';
import 'package:student_portal/student/providers/fee_provider.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/providers/time_table_provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/student/screens/evaluation/evaluation_screen.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/providers/mark_result_provider.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  getIt<NotificationService>().initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor, systemNavigationBarColor: backgroundColor));
  runApp(MultiProvider(
    providers: [
      //other
      ChangeNotifierProvider(create: (_) => SelectedCourseProvider()),
      //auth
      ChangeNotifierProvider(create: (_) => getIt<LoginProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<UserDetailProvider>()),
      //student
      ChangeNotifierProvider(create: (_) => getIt<TimeTableProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<DateSheetProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<AttendanceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<EvaluationProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<TeacherEvaluationProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<EnrollmentProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<FeeProvider>()),

      //teacher
      ChangeNotifierProvider(create: (_) => getIt<CourseSectionProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentAttendanceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<MarkResultProvider>()),
      //admin
      ChangeNotifierProvider(
          create: (_) => getIt<TeacherEvaluationResultProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: LoginScreen(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
