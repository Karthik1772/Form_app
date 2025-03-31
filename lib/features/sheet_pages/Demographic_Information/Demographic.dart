import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/core/common/custom_textfield.dart';
import 'package:demo/features/sheet_pages/Demographic_Information/sheets/googlesheet.dart';
import 'package:demo/features/sheet_pages/Demographic_Information/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Demographic extends StatefulWidget {
  const Demographic({super.key});

  @override
  State<Demographic> createState() => _DemographicState();
}

class _DemographicState extends State<Demographic> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _occupation = TextEditingController();

  bool _isSubmitted = false;
  bool _next = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Demographic Details",
            style: GoogleFonts.varelaRound(
              fontSize: 24,
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
                      CustomTextField(controller: _name, hint: "Name"),
                      const SizedBox(height: 50),
                      CustomTextField(controller: _email, hint: "Email"),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "18-24",
                          "25-34",
                          "35-44",
                          "45-54",
                          "55 and above",
                        ],
                        dropDownController: _age,
                        hintText: 'Age',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Male",
                          "Female",
                          "Non-Binary",
                          "Prefer not to say",
                        ],
                        dropDownController: _gender,
                        hintText: "Gender",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Urban", "SubUrban", "Rural"],
                        dropDownController: _location,
                        hintText: "Location",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Employed",
                          "Student",
                          "Homemaker",
                          "Unemployed",
                          "Other",
                        ],
                        dropDownController: _occupation,
                        hintText: "Occupation",
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
                        if (_isSubmitted) {
                          CustomSnackbar.snackbarShow(
                              context, "Details already submitted.");
                          return;
                        }
                        if (_name.text.trim().isEmpty ||
                            _email.text.trim().isEmpty ||
                            _age.text.trim().isEmpty ||
                            _gender.text.trim().isEmpty ||
                            _location.text.trim().isEmpty ||
                            _occupation.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }

                        final feedback = {
                          SheetsColumn.name: _name.text.trim(),
                          SheetsColumn.email: _email.text.trim(),
                          SheetsColumn.age: _age.text.trim(),
                          SheetsColumn.gender: _gender.text.trim(),
                          SheetsColumn.location: _location.text.trim(),
                          SheetsColumn.occupation: _occupation.text.trim(),
                        };

                        await SheetsFlutter.insert(context, [feedback]);
                        setState(() {
                          _isSubmitted = true;
                        });
                        setState(() {
                          _next = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButtons(
                      text: "Next",
                      onpressed: () {
                        if (_next) {
                        Navigator.pushNamed(context, '/transportation');
                        } else {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please save the details first!",
                          );
                        }
                      },
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
