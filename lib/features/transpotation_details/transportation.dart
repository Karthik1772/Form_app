import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    child: CustomButtons(text: "Save", onpressed: () {}),
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
