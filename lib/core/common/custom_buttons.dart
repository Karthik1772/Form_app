import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtons extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;
  final Color buttoncolor;
  final Color ?loadingcolor;
  final Color textcolor;
  final double fontsize;
  final bool isLoading;
  const CustomButtons({
    super.key,
    required this.text,
    required this.fontsize,
    required this.buttoncolor,
    required this.textcolor,
    required this.onpressed,
    this.isLoading = false,
    this.loadingcolor,
  });

  @override
  State<CustomButtons> createState() => _CustomButtons();
}

class _CustomButtons extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttoncolor,  
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: widget.isLoading ? null : widget.onpressed,
        child:
            widget.isLoading
                ? SizedBox(
                  child: CircularProgressIndicator(
                    color: widget.loadingcolor,  
                    strokeCap: StrokeCap.round,
                  ),
                )
                : Text(
                  widget.text,
                  style: GoogleFonts.varelaRound(
                    color: widget.textcolor,
                    fontSize: widget.fontsize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}