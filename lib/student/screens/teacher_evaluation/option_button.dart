import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key,
      required this.option,
      required this.onTap,
      required this.isSelected});
  final String option;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? primaryColor : secondaryColor,
        child: SizedBox(
          width: 74,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              option,
              style: isSelected
                  ? smallTextStyle.copyWith(color: textColor)
                  : smallTextStyle,
            ),
          )),
        ),
      ),
    );
  }
}
