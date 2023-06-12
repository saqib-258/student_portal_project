import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/providers/fee_provider.dart';

// ignore: must_be_immutable
class InstallmentsScreen extends StatefulWidget {
  const InstallmentsScreen(
      {super.key, required this.noOfInstallments, required this.totalFee});
  final int noOfInstallments;
  final int totalFee;
  @override
  State<InstallmentsScreen> createState() => _GenerateChallanScreenState();
}

class _GenerateChallanScreenState extends State<InstallmentsScreen> {
  List<TextEditingController> installmentControllers = [];
  @override
  void initState() {
    addInstallmentTextFields();
    super.initState();
  }

  void addInstallmentTextFields() {
    for (int i = 0; i < widget.noOfInstallments; i++) {
      installmentControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate Challan")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          "Total installments",
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.noOfInstallments.toString(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          "Total Fee",
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.totalFee.toString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            height10(),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(16),
              itemCount: widget.noOfInstallments,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter installment no. ${index + 1}"),
                      keyboardType: TextInputType.phone,
                      controller: installmentControllers[index]),
                );
              },
            ),
            height30(),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(200, 45)),
                onPressed: () async {
                  if (installmentControllers
                      .where((e) => e.text == "")
                      .toList()
                      .isNotEmpty) {
                    showToast("Please enter all the installments");
                    return;
                  }
                  int sum = installmentControllers.fold(0,
                      (previousValue, controller) {
                    String text = controller.text;
                    int value = int.tryParse(text) ?? 0;
                    return previousValue + value;
                  });

                  if (sum != widget.totalFee) {
                    showToast("Invalid installments amount");
                    return;
                  }
                  bool success = await getIt<FeeProvider>().requestAdmin(
                      installmentControllers
                          .map((e) => int.parse(e.text))
                          .toList());

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  if (success) {
                    showToast("Requested successfully");
                  } else {
                    showToast("Something went wrong");
                  }
                },
                child: const Text("Request Admin"))
          ],
        ),
      ),
    );
  }
}
