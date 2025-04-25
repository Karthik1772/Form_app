import 'package:Formify/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      //__________________________________________________________APP_BAR
      backgroundColor: AppColors.orange,
      iconTheme: IconThemeData(color: AppColors.white),
      actionsIconTheme: IconThemeData(color: AppColors.orange),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      //__________________________________BUTTONS
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.orange),
      ),
    ),
  );
}
