import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/sheet_pages/transpotation_details/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/transpotation_details/sheets/sheetscolumn.dart';
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

  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _primary.text = data[SheetsColumn.primary] ?? '';
    _hybrid.text = data[SheetsColumn.hybrid] ?? '';
    _frequency.text = data[SheetsColumn.frequency] ?? '';
    _pattern.text = data[SheetsColumn.pattern] ?? '';
    _distance.text = data[SheetsColumn.distance] ?? '';
    _pool.text = data[SheetsColumn.pool] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Transportation Details",
              style: GoogleFonts.varelaRound(
                fontSize: 23,
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
                          hintText:
                              'Frequency of using private transportation:',
                        ),
                        const SizedBox(height: 50),
                        CustomDropDown(
                          list: ["Steady and mature", "Rash", "No idea"],
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
                        text: "Next",
                        buttoncolor: AppColors.orange,
                        textcolor: AppColors.white,
                        fontsize: 20,
                        onpressed: () async {
                          if (_primary.text.trim().isEmpty ||
                              _hybrid.text.trim().isEmpty ||
                              _frequency.text.trim().isEmpty ||
                              _pattern.text.trim().isEmpty ||
                              _distance.text.trim().isEmpty ||
                              _pool.text.trim().isEmpty) {
                            CustomSnackbar.show(
                              context: context,
                              text: "Please fill all required fields!",
                              background: AppColors.orange,
                              textcolor: AppColors.white,
                              position: 50,
                            );
                            return;
                          }
                          FormDataService.instance.saveData({
                            SheetsColumn.primary: _primary.text.trim(),
                            SheetsColumn.hybrid: _hybrid.text.trim(),
                            SheetsColumn.frequency: _frequency.text.trim(),
                            SheetsColumn.pattern: _pattern.text.trim(),
                            SheetsColumn.distance: _distance.text.trim(),
                            SheetsColumn.pool: _pool.text.trim(),
                          });
                          final feedback = {
                            SheetsColumn.primary: _primary.text.trim(),
                            SheetsColumn.hybrid: _hybrid.text.trim(),
                            SheetsColumn.frequency: _frequency.text.trim(),
                            SheetsColumn.pattern: _pattern.text.trim(),
                            SheetsColumn.distance: _distance.text.trim(),
                            SheetsColumn.pool: _pool.text.trim(),
                          };

                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/environment');
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
      ),
    );
  }
}
