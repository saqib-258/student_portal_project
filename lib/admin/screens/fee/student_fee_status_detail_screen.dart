import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:student_portal/admin/models/services/student_fee_detail_api.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';

class StudentFeeStatusDetailScreen extends StatefulWidget {
  const StudentFeeStatusDetailScreen({super.key, required this.model});
  final ChallanDetail model;

  @override
  State<StudentFeeStatusDetailScreen> createState() =>
      _FeeStatusDetailScreenState();
}

class _FeeStatusDetailScreenState extends State<StudentFeeStatusDetailScreen> {
  Widget _challanDetailRow(String text, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: boldTextStyle,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fee Chalan Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                height10(),
                Text(
                  'Installment No ${widget.model.installmentNo}',
                  style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                height20(),
                widget.model.challanImage == null
                    ? DottedBorder(
                        color: primaryColor,
                        radius: const Radius.circular(12),
                        borderType: BorderType.RRect,
                        child: SizedBox(
                          height: 120,
                          width: 140,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image),
                                height5(),
                                Text(
                                  "Not yet uploaded",
                                  textAlign: TextAlign.center,
                                  style: smallTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: widget.model.challanImage == null
                            ? null
                            : () {
                                navigate(
                                    context,
                                    PhotoViewerScreen(
                                      photo: getFileUrl("ChallanImages",
                                          widget.model.challanImage!),
                                    ));
                              },
                        child: Hero(
                          tag: getFileUrl(
                              "ChallanImages", widget.model.challanImage!),
                          child: Container(
                              height: 120,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  getFileUrl("ChallanImages",
                                      widget.model.challanImage!),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                height5(),
                Text(
                  "Challan image",
                  style: header3TextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                height10(),
                height20(),
                _challanDetailRow("Receipt No", widget.model.id),
                _challanDetailRow("Amount", widget.model.amount.toString()),
                _challanDetailRow("Issue Date", widget.model.issueDate),
                _challanDetailRow("Expiry Date", widget.model.expiryDate),
                _challanDetailRow(
                    "Status", widget.model.status ? "Done" : "Pending"),
                height20(),
                ElevatedButton(
                    onPressed: widget.model.status
                        ? () {}
                        : widget.model.challanImage == null
                            ? null
                            : () async {
                                EasyLoading.show(
                                    indicator:
                                        const CircularProgressIndicator());
                                await StudentFeeDetailApi.approveInstallment(
                                    widget.model.id);

                                await Future.delayed(
                                    const Duration(seconds: 1));
                                // ignore: use_build_context_synchronously
                                widget.model.status = true;
                                setState(() {});
                                EasyLoading.dismiss();
                              },
                    child: Text(widget.model.status ? "Approved" : "Approve"))
              ],
            ),
          ),
        ));
  }
}
