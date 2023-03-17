import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

class AttendanceProgressIndicator extends StatelessWidget {
  const AttendanceProgressIndicator({super.key, required this.percentage});
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          animation: true,
          animationDuration: 1400,
          lineWidth: 5.0,
          percent: percentage,
          center: Text(
            "${(percentage * 100).round()}%",
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: secondaryCardColor,
          progressColor: primaryColor,
        ),
        height10(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.solidCircle,
              color: primaryColor,
              size: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Present",
                style: smallTextStyle,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                color: secondaryCardColor,
                size: 8,
              ),
            ),
            Text(
              "Absent",
              style: smallTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
