import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  "Occupation Details",
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
                    child: CustomButtons(text: "Save", onpressed: () {}),
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
