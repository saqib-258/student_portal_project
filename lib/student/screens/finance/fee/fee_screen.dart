import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/providers/fee_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:student_portal/student/screens/finance/fee/challan_view.dart';
import 'package:student_portal/student/screens/finance/fee/fee_status_screen.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> with AfterLayoutMixin {
  final provider = getIt<FeeProvider>();
  int totalFee = 0;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await provider.getFeeDetail();
    totalFee = provider.feeDetail!.admissionFee +
        provider.feeDetail!.extraCourseFee +
        provider.feeDetail!.semesterFee +
        provider.feeDetail!.otherFee;
  }

  List<int> _generateInstallments(int totalFee, int numInstallments) {
    List<int> installments = List.filled(numInstallments, 0);

    installments[0] = (totalFee * 0.4).round();

    int remainingFee = totalFee - installments[0];

    if (numInstallments == 2) {
      installments[1] = (remainingFee / 2).round();
    } else if (numInstallments == 3) {
      int remainingInstallments = (remainingFee / 2).round();
      installments[1] = remainingInstallments;
      installments[2] = remainingInstallments;
    }
    int sum = installments.reduce((a, b) => a + b);
    if (sum != totalFee) {
      int diff = totalFee - sum;
      installments[numInstallments - 1] += diff;
    }

    return installments;
  }

  void generateChallanDialog(BuildContext context) {
    int? noOfInstallments;
    List<int> installments = [];

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => provider.isGenerating ? false : true,
              child: StatefulBuilder(
                  builder: (context, setInnerState) => SimpleDialog(
                        contentPadding: const EdgeInsets.all(20),
                        children: [
                          Center(
                            child: Text(
                              "Generate Challan",
                              style: mediumTextStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          height10(),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                alignment: Alignment.center,
                                hint: const Text("No of Installments"),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                value: noOfInstallments,
                                items: const [
                                  DropdownMenuItem(value: 1, child: Text("1")),
                                  DropdownMenuItem(value: 2, child: Text("2")),
                                  DropdownMenuItem(value: 3, child: Text("3")),
                                ],
                                onChanged: (val) {
                                  setInnerState(() {
                                    noOfInstallments = val!;

                                    installments = _generateInstallments(
                                        totalFee, noOfInstallments!);
                                  });
                                }),
                          ),
                          height10(),
                          Column(
                            children: installments
                                .mapIndexed((i, e) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Card(
                                        color: backgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Installment No ${i + 1}"),
                                              Text(e.toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          height20(),
                          Consumer<FeeProvider>(
                              builder: (context, provider, _) {
                            return ElevatedButton(
                                onPressed: installments.isEmpty
                                    ? null
                                    : () async {
                                        await provider
                                            .generateChallan(installments);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        if (provider.challanUrl != null) {
                                          // if (!FlutterDownloader.initialized) {
                                          //   await FlutterDownloader.initialize(
                                          //       debug: true, ignoreSsl: true);
                                          // }
                                          // ignore: use_build_context_synchronously
                                          navigate(
                                              context,
                                              ChallanView(
                                                  challanUrl:
                                                      provider.challanUrl!));
                                        }
                                      },
                                child: provider.isGenerating
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text("Generate"));
                          })
                        ],
                      )),
            ));
  }

  Padding _buildChallanButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: AppButton(
          onTap: () async {
            if (provider.feeDetail!.isChallanGenerated) {
              if (provider.challanUrl == null) {
                await provider.getChallan();
              }
              if (provider.challanUrl != null) {
                // ignore: use_build_context_synchronously
                navigate(
                    context, ChallanView(challanUrl: provider.challanUrl!));
              }
            } else {
              generateChallanDialog(context);
            }
          },
          child: Text(
            provider.feeDetail!.isChallanGenerated
                ? "View Challan"
                : "Generate Challan",
            style: textColorStyle,
          )),
    );
  }

  Padding _buildFeeStatusButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: AppButton(
          isDisabled: provider.feeDetail!.isChallanGenerated ? false : true,
          onTap: () {
            navigate(context, const FeeStatus());
          },
          child: Text(
            "Fee Status",
            style: textColorStyle,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee"),
      ),
      body: Consumer<FeeProvider>(builder: (context, provider, _) {
        if (provider.feeDetail == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            _FeeCard(totalFee: totalFee, provider: provider),
            height30(),
            _buildFeeStatusButton(),
            _buildChallanButton(context)
          ]),
        );
      }),
    );
  }
}

class _FeeCard extends StatelessWidget {
  const _FeeCard({required this.provider, required this.totalFee});
  final FeeProvider provider;
  final int totalFee;
  Widget _buildFeeAmountWidget(String text, String value) {
    return Card(
      color: secondaryCardColor,
      child: SizedBox(
        height: 80,
        width: 116,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: smallTextStyle.copyWith(color: textColor),
              ),
              height5(),
              Text(
                value,
                style: header2TextStyle.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        height: 120,
        child: Card(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Fee",
                style: header1TextStyle.copyWith(color: textColor),
              ),
              height5(),
              Text(
                totalFee.toString(),
                style: header1TextStyle.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3),
              ),
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFeeAmountWidget(
              "Semester Fee", provider.feeDetail!.semesterFee.toString()),
          _buildFeeAmountWidget("Extra Course Fee",
              provider.feeDetail!.extraCourseFee.toString()),
          _buildFeeAmountWidget(
              "Other Fee", provider.feeDetail!.otherFee.toString()),
        ],
      )
    ]);
  }
}
