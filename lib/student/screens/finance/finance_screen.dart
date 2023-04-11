import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/screens/finance/fee/fee_screen.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});
  Widget _buildButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: primaryColor,
        elevation: 4,
        child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Center(
                child: Text(
              text,
              style: mediumTextStyle.copyWith(color: textColor),
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton("Fee", onTap: () {
              navigate(context, const FeeScreen());
            }),
            height10(),
            _buildButton("Fine", onTap: () {}),
            height10(),
            _buildButton("Financial Assistance", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
