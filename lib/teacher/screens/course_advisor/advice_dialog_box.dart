import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/teacher/models/services/course_advisor_api.dart';

class AdviceDialogBox extends StatelessWidget {
  AdviceDialogBox({super.key, required this.regNo, required this.id});
  final TextEditingController controller = TextEditingController();
  final String regNo;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text("Advice Student", style: mediumTextStyle)),
              height5(),
              TextField(
                controller: controller,
                maxLines: 8,
                maxLength: 1000,
                decoration: const InputDecoration(
                    hintText: "Write advice", border: OutlineInputBorder()),
              ),
              height5(),
              ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(
                        indicator: const CircularProgressIndicator());
                    var result = await CourseAdvisorApi.addCourseAdvisorDetail({
                      "reg_no": regNo,
                      "advise": controller.text,
                      "course_advisor_id": id
                    });
                    await Future.delayed(const Duration(seconds: 1));
                    result.fold((l) {
                      showToast("Something went wrong");
                    }, (r) {
                      if (r != null) {
                        showToast("Uploaded successfully");
                      } else {
                        showToast("Something went wrong");
                      }
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  },
                  child: const Text("Advice"))
            ],
          ),
        ),
      ),
    );
  }
}
