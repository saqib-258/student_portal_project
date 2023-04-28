import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/images_picker_bottom_sheet.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';
import 'package:student_portal/student/screens/finance/fee/upload_challan_screen.dart';

class FeeStatusDetailScreen extends StatefulWidget {
  const FeeStatusDetailScreen({super.key, required this.model});
  final ChallanDetail model;

  @override
  State<FeeStatusDetailScreen> createState() => _FeeStatusDetailScreenState();
}

class _FeeStatusDetailScreenState extends State<FeeStatusDetailScreen> {
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

  Future<void> _pickImage(BuildContext context2) async {
    showModalBottomSheet(
      context: context2,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          onImageSourceSelected: (ImageSource imageSource) async {
            XFile? imageFile = await ImagePicker()
                .pickImage(source: imageSource, imageQuality: 50);
            if (imageFile != null) {
              // ignore: use_build_context_synchronously
              await navigate(
                  context2,
                  UploadChallanScreen(
                    photo: File(imageFile.path),
                    id: widget.model.id,
                  ));
              setState(() {});
            }
          },
        );
      },
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
                                  "No image selected",
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
                height10(),
                ElevatedButton(
                    onPressed: widget.model.status
                        ? null
                        : () {
                            _pickImage(context);
                          },
                    child: Text(widget.model.challanImage == null
                        ? "Upload Challan"
                        : "Update Challan")),
                height20(),
                _challanDetailRow("Receipt No", widget.model.id),
                _challanDetailRow("Amount", widget.model.amount.toString()),
                _challanDetailRow("Issue Date", widget.model.issueDate),
                _challanDetailRow("Expiry Date", widget.model.expiryDate),
                _challanDetailRow(
                    "Status", widget.model.status ? "Done" : "Pending")
              ],
            ),
          ),
        ));
  }
}
