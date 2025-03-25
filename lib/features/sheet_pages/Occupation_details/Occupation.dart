import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/features/sheet_pages/Occupation_details/sheets/googlesheet.dart';
import 'package:demo/features/sheet_pages/Occupation_details/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Occupation extends StatefulWidget {
  const Occupation({super.key});

  @override
  State<Occupation> createState() => _Occupation();
}

class _Occupation extends State<Occupation> {
  final TextEditingController _business = TextEditingController();
  final TextEditingController _aprogram = TextEditingController();
  final TextEditingController _seminar = TextEditingController();
  final TextEditingController _distance = TextEditingController();
  final TextEditingController _earn = TextEditingController();
  // bool _isSubmitted = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkSubmissionStatus();
  // }

  // Future<void> _checkSubmissionStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isSubmitted = prefs.getBool('Occupation_Details') ?? false;
  //   });
  // }

  // Future<void> _setSubmissionStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('Occupation_Details', true);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Occupation Details",
            style: GoogleFonts.varelaRound(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _business,
                        hintText: "Do you own a business",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _aprogram,
                        hintText:
                            "Do you do awareness and environment-friendly work",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _seminar,
                        hintText: 'Do you attends seminars / business trips:',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Within city limits",
                          "Within state",
                          "Within country",
                          "International",
                        ],
                        dropDownController: _distance,
                        hintText: 'How far are you',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Annually", "Monthly", "Weekly"],
                        dropDownController: _earn,
                        hintText: 'How often do you earn',
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
                        //       context, "Details already submitted.");
                        //   return;
                        // }
                        if (_business.text.trim().isEmpty ||
                            _aprogram.text.trim().isEmpty ||
                            _seminar.text.trim().isEmpty ||
                            _distance.text.trim().isEmpty ||
                            _earn.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.business: _business.text.trim(),
                          SheetsColumn.aprogram: _aprogram.text.trim(),
                          SheetsColumn.seminar: _seminar.text.trim(),
                          SheetsColumn.distance: _distance.text.trim(),
                          SheetsColumn.earn: _earn.text.trim(),
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
                      onpressed: () => Navigator.pushNamed(context, '/food'),
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
