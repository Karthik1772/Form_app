import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _Food();
}

class _Food extends State<Food> {
  final TextEditingController _diet = TextEditingController();
  final TextEditingController _beef = TextEditingController();
  final TextEditingController _pork = TextEditingController();
  final TextEditingController _mutton = TextEditingController();
  final TextEditingController _milk = TextEditingController();
  final TextEditingController _potato = TextEditingController();
  final TextEditingController _vegetables = TextEditingController();
  final TextEditingController _rice = TextEditingController();
  final TextEditingController _wheat = TextEditingController();
  final TextEditingController _nuts = TextEditingController();

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
                  "Food Consumption",
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
                          "High meat",
                          "Medium meat",
                          "Low meat",
                          "Vegetarian",
                          "Vegan",
                          "Pescetarian",
                          "Other",
                        ],
                        dropDownController: _diet,
                        hintText: "	Type of diet consumed:",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _beef,
                        hintText:
                            "how much beef you consume per week (in kgs):",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _pork,
                        hintText:
                            'how much pork you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _mutton,
                        hintText:
                            'how much mutton you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _milk,
                        hintText:
                            'how much milk you consume per week (in litres):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _potato,
                        hintText:
                            'how much potato you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _vegetables,
                        hintText:
                            'how much vegetables you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _rice,
                        hintText:
                            'how much rice you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _wheat,
                        hintText:
                            'how much other wheat/flour you consume per week (in kgs):',
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "More than 0.5",
                          "0.25 - 0.5",
                          "Up To 0.25",
                          "Never",
                        ],
                        dropDownController: _nuts,
                        hintText:
                            'how much nuts you consume per week (in kgs):',
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
                      onpressed: () => Navigator.pushNamed(context, '/energy'),
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
