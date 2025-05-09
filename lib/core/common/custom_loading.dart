import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoading extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final Color indicatorColor;

  const CustomLoading({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.indicatorColor,
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20,),
            SizedBox(
              height: 60, 
              width: 60,
              child: CircularProgressIndicator(
                strokeWidth: 6, 
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.indicatorColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                widget.message,
                style: GoogleFonts.poppins(
                  color: widget.textColor,
                  fontSize: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
