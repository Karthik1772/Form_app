import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String text,
    required Color background,
    required Color textcolor,
    required double position,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: background,
        duration: const Duration(seconds: 2),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.top + position,
          right: 10,
          left: 10,
        ),
        content: Text(text, style: GoogleFonts.poppins(color: textcolor)),
      ),
    );
  }
}
