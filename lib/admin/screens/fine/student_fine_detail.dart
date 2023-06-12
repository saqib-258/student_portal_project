import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:student_portal/admin/models/core/student_fine.dart';
import 'package:student_portal/admin/models/services/student_fine_api.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';

class StudentFineDetail extends StatefulWidget {
  const StudentFineDetail({super.key, required this.model});
  final StudentFine model;

  @override
  State<StudentFineDetail> createState() =>
      _AssistanceRequestDetailScreenState();
}

class _AssistanceRequestDetailScreenState extends State<StudentFineDetail>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}

  Widget _buttonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryCardColor),
                onPressed: () {
                  TextEditingController controller = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (context) => AppConfirmDialog(
                          isReason: true,
                          controller: controller,
                          title: "Do you want to reject fine?",
                          onConfirm: () async {
                            Navigator.pop(context);
                            EasyLoading.show(
                                indicator: const CircularProgressIndicator());
                            var result = await StudentFineApi.rejectFine(
                                widget.model.id, controller.text);
                            await Future.delayed(const Duration(seconds: 1));
                            result.fold((l) {
                              showToast("Something went wrong");
                            }, (r) {
                              if (r == true) {
                                showToast("Fine Rejected Successfully");
                                widget.model.status = false;
                                setState(() {});
                              } else {
                                showToast("Something went wrong");
                              }
                            });

                            EasyLoading.dismiss();
                          }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Reject",
                    style: textColorStyle,
                  ),
                )),
          ),
          width10(),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AppConfirmDialog(
                          title: "Do you want to accept fine?",
                          onConfirm: () async {
                            Navigator.pop(context);
                            EasyLoading.show(
                                indicator: const CircularProgressIndicator());
                            var result = await StudentFineApi.acceptFine(
                                widget.model.id);
                            await Future.delayed(const Duration(seconds: 1));
                            result.fold((l) {
                              showToast("Something went wrong");
                            }, (r) {
                              if (r == true) {
                                showToast("Fine Accepted Successfully");
                                widget.model.status = true;
                                setState(() {});
                              } else {
                                showToast("Something went wrong");
                              }
                            });

                            EasyLoading.dismiss();
                          }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Accept",
                    style: textColorStyle,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fine Detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Student Detail:",
                        style: boldTextStyle,
                      ),
                      height5(),
                      Text(widget.model.name),
                      Text(widget.model.regNo),
                      Text(
                          'BS${widget.model.program}-${widget.model.semester}${widget.model.section}'),
                      height10(),
                      Text(
                        "Reason:",
                        style: boldTextStyle,
                      ),
                      height5(),
                      Text(widget.model.description),
                      height10(),
                      Text(
                        "Date:",
                        style: boldTextStyle,
                      ),
                      height5(),
                      Text(widget.model.date),
                      height10(),
                      Text(
                        "Status:",
                        style: boldTextStyle,
                      ),
                      height5(),
                      Text(widget.model.status == null
                          ? "Pending"
                          : widget.model.status!
                              ? "Accepted"
                              : "Rejected"),
                      height10(),
                      Text(
                        "Receipt:",
                        style: boldTextStyle,
                      ),
                      height5(),
                      widget.model.receipt == null
                          ? const Text("Not yet uploaded")
                          : Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () {
                                    navigate(
                                        context,
                                        PhotoViewerScreen(
                                            photo: getFileUrl(
                                                "FineReceiptImages",
                                                widget.model.receipt!)));
                                  },
                                  child: Image.network(
                                    getFileUrl("FineReceiptImages",
                                        widget.model.receipt!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                      height5(),
                    ],
                  ),
                ),
              ),
            ),
            height10(),
            widget.model.status == true || widget.model.receipt != null
                ? const SizedBox.shrink()
                : _buttonRow(context)
          ]),
        ),
      ),
    );
  }
}
