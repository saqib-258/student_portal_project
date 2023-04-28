import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/images_picker_bottom_sheet.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/services/financial_assistance_api.dart';
import 'package:student_portal/student/providers/financial_assistance_provider.dart';

class RequestFinancialAssistanceScreen extends StatelessWidget {
  RequestFinancialAssistanceScreen({super.key});
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Assistance"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          getIt<FinancialAssistanceProvider>().clearImages();
          return true;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Request Financial Assistance",
                    style: boldTextStyle.copyWith(fontSize: 16),
                  ),
                ),
                height10(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    textAlign: TextAlign.start,
                    maxLength: 500,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Description",
                        border: OutlineInputBorder(),
                        hintText: "Enter Description"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Note:  Attach images of latest Utility Bills – Electricity, Gas, and Telephone.",
                      style: header3TextStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                height10(),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: primaryColor))),
                    child: const _ImagesRow()),
                height30(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppButton(
                      child: Text(
                        "Submit",
                        style: textColorStyle,
                      ),
                      onTap: () async {
                        if (_descriptionController.text.trim().isEmpty) {
                          showToast("Description must not be empty");
                          return;
                        }
                        if (getIt<FinancialAssistanceProvider>()
                            .images
                            .isEmpty) {
                          showToast("Attach at least one image");
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AppConfirmDialog(
                                title:
                                    "Do you want to request for financial assistance?",
                                onConfirm: () async {
                                  Navigator.pop(context);
                                  EasyLoading.show(
                                      indicator:
                                          const CircularProgressIndicator());
                                  var result = await FinancialAssistanceApi
                                      .requestFinancialAssistance(
                                          _descriptionController.text.trim(),
                                          getIt<FinancialAssistanceProvider>()
                                              .images);
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  result.fold((l) {
                                    showToast("Something went wrong");
                                  }, (r) {
                                    if (r == true) {
                                      showToast(
                                          "Request submitted successfully");
                                    } else {
                                      showToast("Something went wrong");
                                    }
                                  });

                                  EasyLoading.dismiss();
                                }));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagesRow extends StatefulWidget {
  const _ImagesRow();

  @override
  State<_ImagesRow> createState() => _ImagesRowState();
}

class _ImagesRowState extends State<_ImagesRow> {
  Future<void> _pickImage(BuildContext context2) async {
    showModalBottomSheet(
      context: context2,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          onImageSourceSelected: (ImageSource imageSource) async {
            XFile? imageFile = await ImagePicker()
                .pickImage(source: imageSource, imageQuality: 50);
            if (imageFile != null) {
              getIt<FinancialAssistanceProvider>()
                  .addImage(File(imageFile.path));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Consumer<FinancialAssistanceProvider>(
              builder: (context, provider, _) {
            return Row(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            height: 80,
                            width: 90,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  navigate(
                                      context,
                                      FilePhotoViewerScreen(
                                        photo: provider.images[index],
                                      ));
                                },
                                child: Image.file(
                                  provider.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      );
                    }),
                width5(),
                GestureDetector(
                  onTap: () async {
                    _pickImage(context);
                  },
                  child: DottedBorder(
                    color: primaryColor,
                    radius: const Radius.circular(8),
                    borderType: BorderType.RRect,
                    child: SizedBox(
                      height: 80,
                      width: 90,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt),
                            height5(),
                            Text(
                              "Select Photo",
                              style: smallTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
