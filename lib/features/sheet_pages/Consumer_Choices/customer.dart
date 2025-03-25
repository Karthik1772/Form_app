import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/features/sheet_pages/Consumer_Choices/sheets/googlesheet.dart';
import 'package:demo/features/sheet_pages/Consumer_Choices/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _Customer();
}

class _Customer extends State<Customer> {
  final TextEditingController _buy = TextEditingController();
  final TextEditingController _reduce = TextEditingController();
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
                  "Consumer Details",
                  style: GoogleFonts.varelaRound(
                    color: Colors.black,
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
                        list: [
                          "Always",
                          "Often",
                          "Occasionally",
                          "Rarely",
                          "Never",
                        ],
                        dropDownController: _buy,
                        hintText:
                            "How often do you buy locally produced or organic products?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Always",
                          "Often",
                          "Occasionally",
                          "Rarely",
                          "Never",
                        ],
                        dropDownController: _reduce,
                        hintText:
                            "Do you actively reduce single-use plastic consumption?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Very conscious",
                          "Somewhat conscious",
                          "Not very conscious",
                          "Not at all conscious",
                        ],
                        dropDownController: _carbon,
                        hintText:
                            "Are you conscious of the carbon footprint of the products you purchase?",
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
                        if (_buy.text.trim().isEmpty ||
                            _reduce.text.trim().isEmpty||
                            _carbon.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.power: _buy.text.trim(),
                          SheetsColumn.energy: _reduce.text.trim(),
                          SheetsColumn.month: _carbon.text.trim(),
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
                          () => Navigator.pushNamed(context, '/miscellaneous'),
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
