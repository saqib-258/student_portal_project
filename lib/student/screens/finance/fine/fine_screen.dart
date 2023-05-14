import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/images_picker_bottom_sheet.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/common_widgets/upload_image_screen.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/fine.dart';
import 'package:student_portal/student/models/services/fine_api.dart';
import 'package:student_portal/student/providers/fine_provider.dart';

class FineScreen extends StatefulWidget {
  const FineScreen({super.key});

  @override
  State<FineScreen> createState() => _FineScreenState();
}

class _FineScreenState extends State<FineScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<FineProvider>().getFineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fine"),
      ),
      body: Column(
        children: [
          Consumer<FineProvider>(builder: (context, provider, _) {
            if (provider.fList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (provider.fList!.isEmpty) {
              return const Center(
                child: Text("No fine yet"),
              );
            }
            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.fList!.length,
                  itemBuilder: (context, index) {
                    return _FineCard(
                      model: provider.fList![index],
                    );
                  }),
            );
          }),
        ],
      ),
    );
  }
}

class _FineCard extends StatefulWidget {
  const _FineCard({required this.model});
  final Fine model;

  @override
  State<_FineCard> createState() => _FineCardState();
}

class _FineCardState extends State<_FineCard> {
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
                  UploadImageScreen(
                    photo: File(imageFile.path),
                    onUpload: () async {
                      EasyLoading.show(
                          indicator: const CircularProgressIndicator());
                      var result = await FineApi.uploadReceipt(
                          File(imageFile.path), widget.model.id);
                      await Future.delayed(const Duration(seconds: 1));
                      result.fold((l) {
                        showToast("Something went wrong");
                      }, (r) {
                        if (r != null) {
                          showToast("Receipt uploaded successfully");
                          widget.model.receipt = r;
                          setState(() {});
                        } else {
                          showToast("Something went wrong");
                        }
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context2);
                      EasyLoading.dismiss();
                    },
                  ));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Reason: ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
                TextSpan(
                    text: widget.model.description,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18))
              ])),
              height5(),
              Row(
                children: [
                  Text(
                    'Amount: ',
                    style: boldTextStyle,
                  ),
                  Text(
                    '${widget.model.amount}',
                  ),
                ],
              ),
              height5(),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: boldTextStyle,
                  ),
                  Text(
                    widget.model.status == null
                        ? "Pending"
                        : widget.model.status!
                            ? "Paid"
                            : "Rejected",
                  ),
                ],
              ),
              height5(),
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: boldTextStyle,
                  ),
                  Text(
                    widget.model.date,
                  ),
                ],
              ),
              height10(),
              widget.model.receipt == null
                  ? DottedBorder(
                      color: primaryColor,
                      radius: const Radius.circular(8),
                      borderType: BorderType.RRect,
                      child: SizedBox(
                        height: 80,
                        width: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt),
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
                                    photo: getFileUrl("FineReceiptImages",
                                        widget.model.receipt!)));
                          },
                          child: Image.network(
                            getFileUrl(
                                "FineReceiptImages", widget.model.receipt!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
              height5(),
              ElevatedButton(
                  onPressed:
                      widget.model.status == null || !widget.model.status!
                          ? () {
                              _pickImage(context);
                            }
                          : null,
                  child: Text(
                    widget.model.receipt == null
                        ? "Upload receipt"
                        : "Update receipt",
                    style: header3TextStyle,
                  ))
            ],
          ),
        ));
  }
}
