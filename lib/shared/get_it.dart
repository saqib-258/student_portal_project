import 'package:get_it/get_it.dart';
import 'package:student_portal/admin/providers/add_notice_board_provider.dart';
import 'package:student_portal/admin/providers/get_students_provider.dart';
import 'package:student_portal/admin/providers/student_fee_detail_provider.dart';
import 'package:student_portal/admin/providers/student_fee_provider.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/admin/providers/student_fine_provider.dart';
import 'package:student_portal/admin/providers/student_installment_provider.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/auth/login_shred_pref.dart';
import 'package:student_portal/notification/provider/notification_provider.dart';
import 'package:student_portal/notification_service.dart';
import 'package:student_portal/parent/model/children_model.dart';
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
import 'package:student_portal/teacher/providers/course_advisor_provider.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/providers/mark_result_provider.dart';
import 'package:student_portal/teacher/providers/peer_evaluation_provider.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';
import 'package:student_portal/teacher/providers/student_enrollment_provider.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //auth
  getIt.registerSingleton<AuthProvider>(AuthProvider());
  getIt.registerSingleton<LoginSharedPreferences>(LoginSharedPreferences());
  getIt.registerSingleton<UserDetailProvider>(UserDetailProvider());
  //student
  getIt.registerLazySingleton<TimeTableProvider>(() => TimeTableProvider());
  getIt.registerLazySingleton<DateSheetProvider>(() => DateSheetProvider());
  getIt.registerLazySingleton<AttendanceProvider>(() => AttendanceProvider());
  getIt.registerLazySingleton<EvaluationProvider>(() => EvaluationProvider());
  getIt.registerLazySingleton<TeacherEvaluationProvider>(
      () => TeacherEvaluationProvider());
  getIt.registerLazySingleton<FeeProvider>(() => FeeProvider());
  getIt.registerLazySingleton<EnrollmentProvider>(() => EnrollmentProvider());
  getIt.registerLazySingleton<FinancialAssistanceProvider>(
      () => FinancialAssistanceProvider());
  getIt.registerLazySingleton<FineProvider>(() => FineProvider());
  getIt.registerLazySingleton<GetAdviceProvider>(() => GetAdviceProvider());
  getIt.registerLazySingleton<NoticeboardProvider>(() => NoticeboardProvider());
  getIt.registerLazySingleton<PeerEvaluationResultProvider>(
      () => PeerEvaluationResultProvider());

  //teacher
  getIt.registerLazySingleton<CourseSectionProvider>(
      () => CourseSectionProvider());
  getIt.registerLazySingleton<StudentAttendanceProvider>(
      () => StudentAttendanceProvider());
  getIt.registerLazySingleton<MarkResultProvider>(() => MarkResultProvider());
  getIt.registerLazySingleton<StudentEnrollmentProvider>(
      () => StudentEnrollmentProvider());
  getIt.registerLazySingleton<CourseAdvisorProvider>(
      () => CourseAdvisorProvider());
  getIt.registerLazySingleton<PeerEvaluationProvider>(
      () => PeerEvaluationProvider());
  //admin
  getIt.registerLazySingleton<TeacherEvaluationResultProvider>(
      () => TeacherEvaluationResultProvider());
  getIt.registerLazySingleton<StudentFeeProvider>(() => StudentFeeProvider());
  getIt.registerLazySingleton<StudentFeeDetailProvider>(
      () => StudentFeeDetailProvider());
  getIt.registerLazySingleton<StudentFinancialAssistanceRequestsProvider>(
      () => StudentFinancialAssistanceRequestsProvider());
  getIt.registerLazySingleton<StudentFineProvider>(() => StudentFineProvider());
  getIt.registerLazySingleton<GetStudentsProvider>(() => GetStudentsProvider());

  getIt.registerLazySingleton<AddNoticeBoardProvider>(
      () => AddNoticeBoardProvider());
  getIt.registerLazySingleton<StudentInstallmentProvider>(
      () => StudentInstallmentProvider());

  //notification
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerSingleton<NotificationProvider>(NotificationProvider());
  //parent
  getIt.registerLazySingleton<ChildrenModel>(() => ChildrenModel());
}
