import 'package:flutter/material.dart';
import 'package:Formify/core/themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final IconData prefixIcon;
  final bool isotpField;
  final Color? prefixIconColor;
  final Color focused;
  final Color hinttextcolor;
  final Color textcolor;
  final Color? suffixIconColor;
  final TextInputType keyboardType;
  final Color cursor;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hint,
    required this.textcolor,
    required this.focused,
    required this.hinttextcolor,
    required this.cursor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.isObscure = false,
    required this.prefixIcon,
    this.isotpField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure;
  @override
  void initState() {
    isObscure = widget.isObscure;
    super.initState();
  }

  OutlineInputBorder _borderTheme([
    Color borderColor = Colors.grey,
    double width = 1,
  ]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: borderColor, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        cursorColor: widget.cursor,
        cursorHeight: 18,
        style: TextStyle(color: widget.textcolor),
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon, color: widget.prefixIconColor),
          hintStyle: TextStyle(color: widget.hinttextcolor),
          hintText: widget.hint,
          suffixIcon:
              widget.isotpField
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      color: widget.suffixIconColor,
                    ),
                  )
                  : null,
          errorBorder: _borderTheme(AppColors.red, 2),
          focusedBorder: _borderTheme(widget.focused, 2),
          enabledBorder: _borderTheme(),
          disabledBorder: _borderTheme(),
          border: _borderTheme(),
        ),
      ),
    );
  }
}
