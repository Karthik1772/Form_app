import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Miscellaneous extends StatefulWidget {
  const Miscellaneous({super.key});

  @override
  State<Miscellaneous> createState() => _Miscellaneous();
}

class _Miscellaneous extends State<Miscellaneous> {
  final TextEditingController _flight = TextEditingController();
  final TextEditingController _carbon = TextEditingController();

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
                  "Miscellaneous details",
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
                        list: ["None", "1-2 times", "More than 5 times"],
                        dropDownController: _flight,
                        hintText:
                            "How often do you take international flights per year?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: ["Yes", "No"],
                        dropDownController: _carbon,
                        hintText:
                            "Do you participate in carbon offset programs or initiatives?",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButtons(text: "Submit", onpressed: () {}),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
