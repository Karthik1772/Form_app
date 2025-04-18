import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/features/sheet_pages/Energy_Consumption/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Energy_Consumption/sheets/sheetscolumn.dart';
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

  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _power.text = data[SheetsColumn.power] ?? '';
    _energy.text = data[SheetsColumn.energy] ?? '';
    _month.text = data[SheetsColumn.month] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Energy Consumption",
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
                      child: CustomButtons(
                        text: "Next",
                        onpressed: () async {
                          if (_power.text.trim().isEmpty ||
                              _energy.text.trim().isEmpty ||
                              _month.text.trim().isEmpty) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Please fill all required fields!",
                            );
                            return;
                          }
                          FormDataService.instance.saveData({
                            SheetsColumn.power: _power.text.trim(),
                            SheetsColumn.energy: _energy.text.trim(),
                            SheetsColumn.month: _month.text.trim(),
                          });
                          final feedback = {
                            SheetsColumn.power: _power.text.trim(),
                            SheetsColumn.energy: _energy.text.trim(),
                            SheetsColumn.month: _month.text.trim(),
                          };

                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/waste');
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
