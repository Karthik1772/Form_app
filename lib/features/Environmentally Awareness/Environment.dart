import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:demo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Environment extends StatefulWidget {
  const Environment({super.key});

  @override
  State<Environment> createState() => _Environment();
}

class _Environment extends State<Environment> {
  final TextEditingController _garden = TextEditingController();
  final TextEditingController _aprogram = TextEditingController();
  final TextEditingController _trend = TextEditingController();

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
                    child: CustomButtons(text: "Save", onpressed: () {}),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButtons(text: "Next", onpressed: ()=> Navigator.pushNamed(context, '/occupation')),
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
