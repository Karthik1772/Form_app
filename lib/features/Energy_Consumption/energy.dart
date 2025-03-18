import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Energy extends StatefulWidget {
  const Energy({super.key});

  @override
  State<Energy> createState() => _Energy();
}

class _Energy extends State<Energy> {
  final TextEditingController _power = TextEditingController();
  final TextEditingController _energy = TextEditingController();
  final TextEditingController _month = TextEditingController();

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
                  "Energy Consumption",
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
                          "Electricity from the grid",
                          "Solar power",
                          "Wind power",
                          "Other",
                        ],
                        dropDownController: _power,
                        hintText: "Primary source of energy for your home:",
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
                        dropDownController: _energy,
                        hintText:
                            "Do you use energy-efficient appliances and light bulbs?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Less than 100 kWh",
                          "100-300 kWh",
                          "300-500 kWh",
                          "More than 500 kWh",
                        ],
                        dropDownController: _month,
                        hintText:
                            "Average monthly electricity consumption (in kWh):",
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
                      onpressed: () => Navigator.pushNamed(context, '/waste'),
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
