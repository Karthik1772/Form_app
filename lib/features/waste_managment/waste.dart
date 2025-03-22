import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Waste extends StatefulWidget {
  const Waste({super.key});

  @override
  State<Waste> createState() => _Waste();
}

class _Waste extends State<Waste> {
  final TextEditingController _power = TextEditingController();
  final TextEditingController _energy = TextEditingController();

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
                  "Waste Management",
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
                        dropDownController: _power,
                        hintText: "Do you practice recycling at home?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Composting",
                          "Municipal waste collection",
                          "Other",
                        ],
                        dropDownController: _energy,
                        hintText: "How do you manage your organic waste?",
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
                          () => Navigator.pushNamed(context, '/customer'),
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
