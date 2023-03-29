import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key, required this.courseSection});
  final CourseSection courseSection;

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen>
    with AfterLayoutMixin {
  final provider = getIt<StudentAttendanceProvider>();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    provider.getStudents(widget.courseSection.section, widget.courseSection.id);
    provider.changeDate(DateTime.now());
    provider.clearImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
        ),
        body: Consumer<StudentAttendanceProvider>(
          builder: (context, provider, _) {
            if (provider.sList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(
                                    widget.courseSection.courseName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: mediumTextStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                height10(),
                                Text(
                                  'BS${widget.courseSection.program}-${widget.courseSection.semester}${widget.courseSection.section}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              provider.selectedDate.toString().split(' ')[0],
                            ),
                            Text(getWeekDay(provider.selectedDate!)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0, thickness: 1.4),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                        height: 60,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            provider.images[index],
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  );
                                }),
                            width5(),
                            GestureDetector(
                              onTap: () async {
                                XFile? imageFile = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 25);
                                if (imageFile != null) {
                                  provider.addImage(File(imageFile.path));
                                }
                              },
                              child: DottedBorder(
                                color: primaryColor,
                                radius: const Radius.circular(8),
                                borderType: BorderType.RRect,
                                child: SizedBox(
                                  height: 60,
                                  width: 85,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.camera_alt),
                                        height5(),
                                        Text(
                                          "Take Photo",
                                          style: smallTextStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 0, thickness: 1.4),
                  height20(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.sList!.length,
                        itemBuilder: (context, index) {
                          String url = "";
                          if (provider.sList![index].profilePhoto != null) {
                            url =
                                'http://$ip/StudentPortal/ProfileImages/${provider.sList![index].profilePhoto!}';
                          }
                          return ListTile(
                            leading: provider.sList![index].profilePhoto == null
                                ? const CircleAvatar(
                                    radius: 24,
                                    backgroundImage: AssetImage(
                                        "assets/images/avatar-icon.png"))
                                : GestureDetector(
                                    onTap: () {
                                      navigate(context,
                                          PhotoViewerScreen(photo: url));
                                    },
                                    child: Hero(
                                      tag: url,
                                      child: CircleAvatar(
                                          backgroundColor: primaryColor,
                                          radius: 24,
                                          backgroundImage: NetworkImage(url)),
                                    ),
                                  ),
                            title: Text(provider.sList![index].name),
                            subtitle: Text(provider.sList![index].regNo),
                            trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        provider.sList![index].status == "A"
                                            ? secondaryCardColor
                                            : null),
                                onPressed: () {
                                  provider.onMarkClick(index);
                                },
                                child: Text(provider.sList![index].status)),
                          );
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: AppButton(
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () async {
                          bool? isDone = await provider.markAttendace(
                              widget.courseSection.allocationId!);

                          if (isDone != null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text("Submitted successfully")));
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        }),
                  )
                ],
              );
            }
          },
        ));
  }
}
