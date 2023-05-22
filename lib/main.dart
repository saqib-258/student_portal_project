import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/add_notice_board_provider.dart';
import 'package:student_portal/admin/providers/get_students_provider.dart';
import 'package:student_portal/admin/providers/student_fee_detail_provider.dart';
import 'package:student_portal/admin/providers/student_fee_provider.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/admin/providers/student_fine_provider.dart';
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
import 'package:student_portal/student/providers/financial_assistance_provider.dart';
import 'package:student_portal/student/providers/fine_provider.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/providers/time_table_provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/student/screens/evaluation/evaluation_screen.dart';
import 'package:student_portal/teacher/providers/course_advisor_provider.dart';
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
      ChangeNotifierProvider(
          create: (_) => getIt<FinancialAssistanceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<FineProvider>()),

      //teacher
      ChangeNotifierProvider(create: (_) => getIt<CourseSectionProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentAttendanceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<MarkResultProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<CourseAdvisorProvider>()),

      //admin
      ChangeNotifierProvider(
          create: (_) => getIt<TeacherEvaluationResultProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentFeeProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentFeeDetailProvider>()),
      ChangeNotifierProvider(
          create: (_) => getIt<StudentFinancialAssistanceRequestsProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentFineProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<GetStudentsProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<AddNoticeBoardProvider>()),
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
        child = ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
        child = EasyLoading.init()(context, child);
        return child;
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
