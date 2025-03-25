import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/core/themes/app_colors.dart';
import 'package:demo/features/sheet_pages/Miscellaneous_details/sheets/googlesheet.dart';
import 'package:demo/features/sheet_pages/Miscellaneous_details/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Miscellaneous extends StatefulWidget {
  const Miscellaneous({super.key});

  @override
  State<Miscellaneous> createState() => _Miscellaneous();
}

class _Miscellaneous extends State<Miscellaneous> {
  final TextEditingController _flight = TextEditingController();
  final TextEditingController _carbon = TextEditingController();
  // bool _isSubmitted = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkSubmissionStatus();
  // }

  // Future<void> _checkSubmissionStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isSubmitted = prefs.getBool('demographic_submitted') ?? false;
  //   });
  // }

  // Future<void> _setSubmissionStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('demographic_submitted', true);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "Miscellaneous details",
                  style: GoogleFonts.varelaRound(
                    color: AppColors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomDropDown(
                        list: ["None", "1-2 times", "More than 5 times"],
                        dropDownController: _flight,
                        hintText:
                            "How often do you take international flights per year?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _carbon,
                        hintText:
                            "Do you participate in carbon offset programs or initiatives?",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: CustomButtons(
                      text: "Save",
                      onpressed: () async {
                        // if (_isSubmitted) {
                        //   CustomSnackbar.snackbarShow(
                        //       context, "Details already submitted.");
                        //   return;
                        // }
                        if (_flight.text.trim().isEmpty ||
                            _carbon.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.flight: _flight.text.trim(),
                          SheetsColumn.carbon: _carbon.text.trim(),
                        };

                        await SheetsFlutter.insert(context, [feedback]);
                        // await _setSubmissionStatus();
                        // setState(() {
                        //   _isSubmitted = true;
                        // });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButtons(
                      text: "Next",
                      onpressed:
                          () => Navigator.pushNamed(context, '/transportation'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
