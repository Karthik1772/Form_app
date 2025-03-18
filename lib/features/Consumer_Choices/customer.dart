import 'package:demo/core/common/custom_buttons.dart';
import 'package:demo/core/common/custom_drop.dart';
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
                    child: CustomButtons(text: "Save", onpressed: () {}),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButtons(
                      text: "Next",
                      onpressed: () => Navigator.pushNamed(context, '/miscellaneous'),
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
