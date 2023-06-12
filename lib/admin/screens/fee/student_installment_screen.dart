import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/models/services/student_installment_api.dart';
import 'package:student_portal/admin/providers/student_installment_provider.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';

class StudentInstallmentScreen extends StatefulWidget {
  const StudentInstallmentScreen({super.key});

  @override
  State<StudentInstallmentScreen> createState() =>
      _StudentInstallmentScreenState();
}

class _StudentInstallmentScreenState extends State<StudentInstallmentScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<StudentInstallmentProvider>().getInstallmentRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Installment Requests"),
      ),
      body:
          Consumer<StudentInstallmentProvider>(builder: (context, provider, _) {
        if (provider.sList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.sList!.isEmpty) {
          return const Center(child: Text("No data found"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.sList!.length,
          itemBuilder: (context, index) {
            final model = provider.sList![index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              model.profilephoto == null
                                  ? const CircleAvatar(
                                      radius: 24,
                                      backgroundColor: primaryColor,
                                      backgroundImage: AssetImage(
                                          "assets/images/avatar-icon.png"),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        navigate(
                                            context,
                                            PhotoViewerScreen(
                                                photo: getFileUrl(
                                                    "ProfileImages",
                                                    model.profilephoto!)));
                                      },
                                      child: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: primaryColor,
                                        backgroundImage: NetworkImage(
                                            getFileUrl("ProfileImages",
                                                model.profilephoto!)),
                                      ),
                                    ),
                              width10(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.name!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(model.regno!),
                                    Text(
                                        'BS${model.program}-${model.semester}${model.section}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    height10(),
                    Card(
                      color: secondaryCardColor,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: model.installments!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                    "Installment no ${model.installments![index]!.installmentno}"),
                              ),
                              Expanded(
                                child: Text(
                                    "Amount ${model.installments![index]!.amount}"),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AppConfirmDialog(
                                      title: "Do you want to reject request?",
                                      onConfirm: () async {
                                        Navigator.pop(context);
                                        EasyLoading.show(
                                            maskType: EasyLoadingMaskType.black,
                                            indicator:
                                                const CircularProgressIndicator());
                                        var result = await StudentInstallmentApi
                                            .rejectInstallmentRequest(
                                                model.id!);
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        result.fold((l) {
                                          showToast("Something went wrong");
                                        }, (r) {
                                          if (r == true) {
                                            showToast("Rejected successfully");
                                            provider.sList!.removeWhere(
                                                (element) =>
                                                    element.id == model.id);
                                            setState(() {});
                                          } else {
                                            showToast("Something went wrong");
                                          }
                                        });

                                        EasyLoading.dismiss();
                                      }));
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AppConfirmDialog(
                                      title: "Do you want to accept request?",
                                      onConfirm: () async {
                                        Navigator.pop(context);
                                        EasyLoading.show(
                                            maskType: EasyLoadingMaskType.black,
                                            indicator:
                                                const CircularProgressIndicator());
                                        var result = await StudentInstallmentApi
                                            .acceptInstallmentRequest(
                                                model.id!);
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        result.fold((l) {
                                          showToast("Something went wrong");
                                        }, (r) {
                                          if (r == true) {
                                            showToast("Accepted successfully");
                                            provider.sList!.removeWhere(
                                                (element) =>
                                                    element.id == model.id);
                                            setState(() {});
                                          } else {
                                            showToast("Something went wrong");
                                          }
                                        });

                                        EasyLoading.dismiss();
                                      }));
                            },
                            icon: const Icon(Icons.done))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
