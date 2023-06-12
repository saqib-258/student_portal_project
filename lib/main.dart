import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/add_notice_board_provider.dart';
import 'package:student_portal/admin/providers/get_students_provider.dart';
import 'package:student_portal/admin/providers/student_fee_detail_provider.dart';
import 'package:student_portal/admin/providers/student_fee_provider.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/admin/providers/student_fine_provider.dart';
import 'package:student_portal/admin/providers/student_installment_provider.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/admin/screens/dashboard/dashboard_screen.dart';
import 'package:student_portal/auth/login_shred_pref.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/notification/notification_handler.dart';
import 'package:student_portal/notification/provider/notification_provider.dart';
import 'package:student_portal/notification/screens/notification_sccreen.dart';
import 'package:student_portal/notification_service.dart';
import 'package:student_portal/parent/dahboard/parent_dashboard.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/app_theme.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';
import 'package:student_portal/student/providers/date_sheet_provider.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/student/providers/enrollment_provider.dart';
import 'package:student_portal/student/providers/evaluation_provider.dart';
import 'package:student_portal/student/providers/fee_provider.dart';
import 'package:student_portal/student/providers/financial_assistance_provider.dart';
import 'package:student_portal/student/providers/fine_provider.dart';
import 'package:student_portal/student/providers/get_advice_provider.dart';
import 'package:student_portal/student/providers/noticeboard_provider.dart';
import 'package:student_portal/student/providers/peer_evaluation_result_provider.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/providers/time_table_provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/student/screens/dashboard/student_dashboard.dart';
import 'package:student_portal/student/screens/evaluation/evaluation_screen.dart';
import 'package:student_portal/teacher/providers/course_advisor_provider.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/providers/mark_result_provider.dart';
import 'package:student_portal/teacher/providers/peer_evaluation_provider.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';
import 'package:student_portal/teacher/screens/dashboard/teacher_dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor, systemNavigationBarColor: backgroundColor));
  runApp(MultiProvider(
    providers: [
      //other
      ChangeNotifierProvider(create: (_) => SelectedCourseProvider()),
      ChangeNotifierProvider(create: (_) => getIt<NotificationProvider>()),
      //auth
      ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
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
      ChangeNotifierProvider(create: (_) => getIt<GetAdviceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<NoticeboardProvider>()),
      ChangeNotifierProvider(
          create: (_) => getIt<PeerEvaluationResultProvider>()),

      //teacher
      ChangeNotifierProvider(create: (_) => getIt<CourseSectionProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<StudentAttendanceProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<MarkResultProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<CourseAdvisorProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<PeerEvaluationProvider>()),

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
      ChangeNotifierProvider(
          create: (_) => getIt<StudentInstallmentProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? loggedUser;
  bool isLoaded = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    loggedUser = await getIt<LoginSharedPreferences>().getLastLoginValue();
    if (loggedUser != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

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
      home: loggedUser == null || !isLoaded
          ? LoginScreen()
          : Home(user: loggedUser!),
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

class Home extends StatefulWidget {
  const Home({super.key, required this.user});
  final User user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    initializeNotificationSetting();
    initiateNotification();
    super.initState();
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      if (payload!.isNotEmpty) {
        await OpenFilex.open(payload);
      }
      if (payload == "app_notification") {
        // ignore: use_build_context_synchronously
        navigate(context, const NotificationScreen());
      }
    }
  }

  Future<void> initializeNotificationSetting() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await getIt<NotificationService>().notifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  initiateNotification() {
    NotificationHandler.getNotification();
  }

  Widget? getScreen() {
    getIt<UserDetailProvider>().loggedUser(widget.user.username);
    if (widget.user.role == "parent") {
      return const ParentDashboard();
    }
    getIt<UserDetailProvider>().getUser(widget.user.username, widget.user.role);
    if (widget.user.role == "student") {
      return const StudentDashboard();
    } else if (widget.user.role == "admin") {
      return const AdminDashboard();
    } else if (widget.user.role == "teacher") {
      getIt<CourseSectionProvider>().getCourseSection();
      return const TeacherDashboard();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return getScreen()!;
  }
}
