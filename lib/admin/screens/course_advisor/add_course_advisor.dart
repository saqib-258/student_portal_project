import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/admin/models/services/add_course_advisor_api.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/utils/images.dart';

// ignore: must_be_immutable
class AddCourseAdvisor extends StatelessWidget {
  AddCourseAdvisor({super.key});
  File? _excelFile;

  void _pickExcelFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      _excelFile = File(result.files.single.path!);
      final api = AddCourseAdvisorApi();
      var data = await api.addCourseAdvisor(_excelFile!);
      data.fold((l) {
        showToast("something went wrong");
      }, (r) {
        if (!r) {
          showToast("something went wrong");
        } else {
          showToast("Course Advisors added");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add Course Advisor"),
        ),
        body: Center(
          child: Column(children: [
            const Spacer(
              flex: 3,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                  color: backgroundColor, shape: BoxShape.circle),
              child: Center(
                  child: Image.asset(
                uploadFileImage,
                height: 150,
              )),
            ),
            height30(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: const Size(180, 45)),
                onPressed: () {
                  _pickExcelFile(context);
                },
                child: const Text(
                  "Upload file",
                  style: TextStyle(fontSize: 18),
                )),
            const Spacer(flex: 4),
          ]),
        ));
  }
}
