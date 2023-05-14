import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:student_portal/admin/models/core/student_detail_model.dart';
import 'package:student_portal/admin/models/services/student_fine_api.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

class AddFineScreen extends StatelessWidget {
  AddFineScreen({super.key, required this.model});
  final StudentDetailModel model;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Fine"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student Detail:",
                  style: boldTextStyle,
                ),
                height5(),
                Text(model.name),
                Text(model.regNo),
                Text('BS${model.program}-${model.semester}${model.section}'),
                height10(),
                TextFormField(
                  controller: _reasonController,
                  textAlign: TextAlign.start,
                  maxLength: 500,
                  maxLines: 6,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Reason",
                      border: OutlineInputBorder(),
                      hintText: "Enter Reason"),
                ),
                height20(),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Amount",
                      border: OutlineInputBorder(),
                      hintText: "Enter Amount"),
                ),
                height20(),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AppConfirmDialog(
                                  title: "Do you want to add fine?",
                                  onConfirm: () async {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pop(context);
                                    EasyLoading.show(
                                        indicator:
                                            const CircularProgressIndicator());
                                    var result = await StudentFineApi.addFine({
                                      "reg_no": model.regNo,
                                      "amount":
                                          int.parse(_amountController.text),
                                      "description": _reasonController.text
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    result.fold((l) {
                                      showToast("Something went wrong");
                                    }, (r) {
                                      if (r == true) {
                                        showToast("Fine Added Successfully");
                                      } else {
                                        showToast("Something went wrong");
                                      }
                                    });

                                    EasyLoading.dismiss();
                                  }));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add Fine"),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
