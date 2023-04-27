import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

ThemeData buildAppTheme() {
  return ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
            overlayColor:
                MaterialStateProperty.all(primaryColor.withOpacity(0.1)))),
    iconTheme: const IconThemeData(color: primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: primaryColor, suffixIconColor: primaryColor),
    textTheme: GoogleFonts.montserratTextTheme(),
    appBarTheme: AppBarTheme(
        color: primaryColor,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 17,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(size: 22, color: textColor)),
  );
}
