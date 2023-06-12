import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/models/core/student_financial_assistance_request.dart';
import 'package:student_portal/admin/models/services/student_financial_assistance_requests_api.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';

class AssistanceRequestDetailScreen extends StatefulWidget {
  const AssistanceRequestDetailScreen({super.key, required this.model});
  final StudentFinancialAssistanceRequest model;

  @override
  State<AssistanceRequestDetailScreen> createState() =>
      _AssistanceRequestDetailScreenState();
}

class _AssistanceRequestDetailScreenState
    extends State<AssistanceRequestDetailScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<StudentFinancialAssistanceRequestsProvider>()
        .getImages(widget.model.id);
  }

  Widget _getImagesRow() {
    return Consumer<StudentFinancialAssistanceRequestsProvider>(
        builder: (context, provider, _) {
      if (provider.iList == null) {
        return const SizedBox.shrink();
      }
      if (provider.iList!.isEmpty) {
        return const Text("No images");
      }
      return SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.iList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                    height: 60,
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
                                  photo: getFileUrl("FinancialAssistanceImages",
                                      provider.iList![index])));
                        },
                        child: Image.network(
                          getFileUrl("FinancialAssistanceImages",
                              provider.iList![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              );
            }),
      );
    });
  }

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
                          title: "Do you want to reject request?",
                          onConfirm: () async {
                            Navigator.pop(context);
                            EasyLoading.show(
                                indicator: const CircularProgressIndicator());
                            var result =
                                await StudentFinancialAssistanceRequestsApi
                                    .rejectFinancialAssistanceRequest(
                                        widget.model.id, controller.text);
                            await Future.delayed(const Duration(seconds: 1));
                            result.fold((l) {
                              showToast("Something went wrong");
                            }, (r) {
                              if (r == true) {
                                showToast("Request Rejected Successfully");
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
                          title: "Do you want to accept request?",
                          onConfirm: () async {
                            Navigator.pop(context);
                            EasyLoading.show(
                                indicator: const CircularProgressIndicator());
                            var result =
                                await StudentFinancialAssistanceRequestsApi
                                    .acceptFinancialAssistanceRequest(
                                        widget.model.id);
                            await Future.delayed(const Duration(seconds: 1));
                            result.fold((l) {
                              showToast("Something went wrong");
                            }, (r) {
                              if (r == true) {
                                showToast("Request Accepted Successfully");
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
        title: const Text("Request Detail"),
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
                        "Description:",
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
                        "Images:",
                        style: boldTextStyle,
                      ),
                      _getImagesRow(),
                      height5(),
                    ],
                  ),
                ),
              ),
            ),
            height10(),
            widget.model.status != null
                ? const SizedBox.shrink()
                : _buttonRow(context)
          ]),
        ),
      ),
    );
  }
}
