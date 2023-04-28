import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/screens/finance/fee/fee_screen.dart';
import 'package:student_portal/student/screens/finance/financial_assistance/request_financial_assistance_screen.dart';
import 'package:student_portal/student/screens/finance/fine/fine_screen.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});
  Widget _buildButton(String text, IconData iconData,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: primaryColor,
        elevation: 4,
        child: SizedBox(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(
                    iconData,
                    color: textColor,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    text,
                    style: textColorStyle.copyWith(fontSize: 16),
                  ),
                ),
              ],
            )),
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 6),
            Text(
              "What would you like to do?",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 2),
            _buildButton("Fee", FontAwesomeIcons.dollarSign, onTap: () {
              navigate(context, const FeeScreen());
            }),
            const Spacer(),
            _buildButton("Fine", FontAwesomeIcons.circleExclamation, onTap: () {
              navigate(context, const FineScreen());
            }),
            const Spacer(),
            _buildButton(
                "Financial Assistance", FontAwesomeIcons.circleDollarToSlot,
                onTap: () {
              navigate(context, RequestFinancialAssistanceScreen());
            }),
            const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
