import 'package:get_it/get_it.dart';
import 'package:student_portal/admin/providers/teacher_evaluation_result_provider.dart';
import 'package:student_portal/student/providers/attendance_provider.dart';
import 'package:student_portal/student/providers/date_sheet_provider.dart';
import 'package:student_portal/auth/provider/login_provider.dart';
import 'package:student_portal/student/providers/enrollment_provider.dart';
import 'package:student_portal/student/providers/evaluation_provider.dart';
import 'package:student_portal/student/providers/fee_provider.dart';
import 'package:student_portal/student/providers/teacher_evaluation_provider.dart';
import 'package:student_portal/student/providers/time_table_provider.dart';
import 'package:student_portal/auth/provider/user_detail_provider.dart';
import 'package:student_portal/teacher/providers/course_section_provider.dart';
import 'package:student_portal/teacher/providers/mark_result_provider.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';
import 'package:student_portal/teacher/providers/student_enrollment_provider.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //auth
  getIt.registerSingleton<LoginProvider>(LoginProvider());
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
  //teacher
  getIt.registerLazySingleton<CourseSectionProvider>(
      () => CourseSectionProvider());
  getIt.registerLazySingleton<StudentAttendanceProvider>(
      () => StudentAttendanceProvider());
  getIt.registerLazySingleton<MarkResultProvider>(() => MarkResultProvider());
  getIt.registerLazySingleton<StudentEnrollmentProvider>(
      () => StudentEnrollmentProvider());
  //admin
  getIt.registerLazySingleton<TeacherEvaluationResultProvider>(
      () => TeacherEvaluationResultProvider());
}
