import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/core/themes/app_colors.dart';
import 'package:demo/features/transpotation_details/sheets/googlesheet.dart';
import 'package:demo/features/transpotation_details/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transportation extends StatefulWidget {
  const Transportation({super.key});

  @override
  State<Transportation> createState() => _TransportationState();
}

class _TransportationState extends State<Transportation> {
  final TextEditingController _primary = TextEditingController();
  final TextEditingController _hybrid = TextEditingController();
  final TextEditingController _frequency = TextEditingController();
  final TextEditingController _pattern = TextEditingController();
  final TextEditingController _distance = TextEditingController();
  final TextEditingController _pool = TextEditingController();

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
                  "Transportation Details",
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
                        list: [
                          "Private car",
                          "Public transportation",
                          "Bicycle",
                          "Walking",
                          "Motorcycle/scooter",
                          "Other (please specify)",
                        ],
                        dropDownController: _primary,
                        hintText: "Primary mode of transportation",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _hybrid,
                        hintText: "Do you own an electric or hybrid vehicle?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Daily",
                          "Several times a week",
                          "Occasionally",
                          "Rarely",
                        ],
                        dropDownController: _frequency,
                        hintText: 'Frequency of using private transportation:',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Steady and mature",
                          "Steady and mature",
                          "Rash",
                          "No idea",
                        ],
                        dropDownController: _pattern,
                        hintText: "Driving pattern:",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Less than 5 km",
                          "5-10 km",
                          "10-20 km",
                          "More than 20 km",
                        ],
                        dropDownController: _distance,
                        hintText:
                            "Average distance traveled per day (in kilometers):",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _pool,
                        hintText: "Do you carpool or share rides?",
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
                        if (_primary.text.trim().isEmpty ||
                            _hybrid.text.trim().isEmpty ||
                            _frequency.text.trim().isEmpty ||
                            _pattern.text.trim().isEmpty ||
                            _distance.text.trim().isEmpty ||
                            _pool.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.primaryTransport: _primary.text.trim(),
                          SheetsColumn.hybridVehicle: _hybrid.text.trim(),
                          SheetsColumn.frequency: _frequency.text.trim(),
                          SheetsColumn.drivingPattern: _pattern.text.trim(),
                          SheetsColumn.distance: _distance.text.trim(),
                          SheetsColumn.carpool: _pool.text.trim(),
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
                          () => Navigator.pushNamed(context, '/environment'),
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
