import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/core/themes/app_colors.dart';
import 'package:demo/features/sheet_pages/Environmentally_Awareness/sheets/googlesheet.dart';
import 'package:demo/features/sheet_pages/Environmentally_Awareness/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Environment extends StatefulWidget {
  const Environment({super.key});

  @override
  State<Environment> createState() => _Environment();
}

class _Environment extends State<Environment> {
  final TextEditingController _garden = TextEditingController();
  final TextEditingController _aprogram = TextEditingController();
  final TextEditingController _trend = TextEditingController();

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
                  "Environmentally Awareness",
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
                        list: ["Yes", "No"],
                        dropDownController: _garden,
                        hintText: "Do you do gardening",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _aprogram,
                        hintText: "Do you attends awareness programs",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _trend,
                        hintText:
                            'Are you aware of trending sustainable features',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButtons(
                      text: "Save",
                      onpressed: () async {
                        // if (_isSubmitted) {
                        //   CustomSnackbar.snackbarShow(
                        //     context,
                        //     "Details already submitted.",
                        //   );
                        //   return;
                        // }
                        if (_garden.text.trim().isEmpty ||
                            _aprogram.text.trim().isEmpty ||
                            _trend.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.gardens: _garden.text.trim(),
                          SheetsColumn.awarness: _aprogram.text.trim(),
                          SheetsColumn.trends: _trend.text.trim(),
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
                          () => Navigator.pushNamed(context, '/occupation'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
