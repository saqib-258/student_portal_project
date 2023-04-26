import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

class AppFilterButton extends StatelessWidget {
  const AppFilterButton(
      {super.key,
      required this.text,
      required this.val,
      required this.onTap,
      required this.selected});
  final String text;
  final String val;
  final VoidCallback onTap;
  final String selected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected == val ? primaryColor : null,
        shape: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            text,
            style: selected == val ? textColorStyle : null,
          ),
        ),
      ),
    );
  }
}
