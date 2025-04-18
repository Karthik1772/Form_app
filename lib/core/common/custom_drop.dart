import 'package:Formify/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> list;
  final TextEditingController dropDownController;
  final Color textColor;
  final double fontSize;
  final TextStyle? textStyle;
  final double? dropdownWidth;
  final double dropdownHeight;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color arrowColor;
  final String hintText;
  final String? initialValue;

  const CustomDropDown({
    super.key,
    required this.list,
    required this.dropDownController,
    this.textColor = AppColors.lightorange,
    this.fontSize = 14,
    this.textStyle,
    this.dropdownWidth,
    this.dropdownHeight = 50,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = AppColors.orange,
    this.arrowColor = AppColors.orange,
    required this.hintText,
    this.initialValue,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _showTextField = false;
  final TextEditingController _otherTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.dropDownController.text.isEmpty && widget.initialValue != null) {
      widget.dropDownController.text = widget.initialValue!;
    }

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    
    _checkIfOtherSelected();
  }

  void _checkIfOtherSelected() {
    if (widget.dropDownController.text == "Other") {
      setState(() {
        _showTextField = true;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _otherTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = widget.dropdownWidth ?? 
        MediaQuery.of(context).size.width - 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: effectiveWidth,
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    secondary: widget.arrowColor,
                    onSurface: widget.arrowColor,
                  ),
              iconTheme: IconThemeData(color: widget.arrowColor),
            ),
            child: DropdownMenu<String>(
              controller: widget.dropDownController,
              width: effectiveWidth,
              initialSelection: widget.dropDownController.text.isNotEmpty ? 
                  widget.dropDownController.text : null,
              focusNode: _focusNode,
              onSelected: (String? value) {
                if (value != null) {
                  setState(() {
                    widget.dropDownController.text = value;
                    _showTextField = value == "Other";
                    
                    // If not "Other", clear the other text controller
                    if (value != "Other") {
                      _otherTextController.clear();
                    }
                  });
                }
              },
              dropdownMenuEntries: widget.list
                  .map<DropdownMenuEntry<String>>(
                    (String value) => DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          GoogleFonts.varelaRound(
                            fontSize: widget.fontSize,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              textStyle: widget.textStyle ?? GoogleFonts.varelaRound(
                color: widget.textColor,
                fontSize: widget.fontSize,
              ),
              menuStyle: MenuStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              label: Text(
                widget.hintText,
                style: GoogleFonts.varelaRound(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                floatingLabelStyle: GoogleFonts.varelaRound(
                  color: widget.focusedBorderColor,
                  fontSize: widget.fontSize,
                ),
                hintStyle: GoogleFonts.varelaRound(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isFocused ? widget.focusedBorderColor : widget.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isFocused ? widget.focusedBorderColor : widget.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIconColor: MaterialStateColor.resolveWith(
                  (states) => widget.arrowColor,
                ),
                prefixIconColor: MaterialStateColor.resolveWith(
                  (states) => widget.arrowColor,
                ),
                iconColor: MaterialStateColor.resolveWith(
                  (states) => widget.arrowColor,
                ),
              ),
            ),
          ),
        ),
        if (_showTextField)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: effectiveWidth,
            child: TextField(
              controller: _otherTextController,
              style: GoogleFonts.varelaRound(
                color: widget.textColor,
                fontSize: widget.fontSize,
              ),
              decoration: InputDecoration(
                hintText: "Please specify",
                hintStyle: GoogleFonts.varelaRound(
                  color: widget.textColor.withOpacity(0.7),
                  fontSize: widget.fontSize,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
              },
            ),
          ),
      ],
    );
  }
}