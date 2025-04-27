import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/sheet_pages/Food_Consumption/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Food_Consumption/sheets/sheetscolumn.dart';
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

  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _diet.text = data[SheetsColumn.diet] ?? '';
    _beef.text = data[SheetsColumn.beef] ?? '';
    _pork.text = data[SheetsColumn.pork] ?? '';
    _mutton.text = data[SheetsColumn.mutton] ?? '';
    _milk.text = data[SheetsColumn.milk] ?? '';
    _potato.text = data[SheetsColumn.potato] ?? '';
    _vegetables.text = data[SheetsColumn.vegetables] ?? '';
    _rice.text = data[SheetsColumn.rice] ?? '';
    _wheat.text = data[SheetsColumn.wheat] ?? '';
    _nuts.text = data[SheetsColumn.nuts] ?? '';
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
              "Food Consumption",
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
                  child: Scrollbar(
                    thumbVisibility: true,
                    thickness: 5,
                    radius: Radius.circular(10),
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
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButtons(
                        text: "Next",
                        fontsize: 20,
                        buttoncolor: AppColors.orange,
                        textcolor: AppColors.white,
                        onpressed: () async {
                          if (_diet.text.trim().isEmpty ||
                              _beef.text.trim().isEmpty ||
                              _pork.text.trim().isEmpty ||
                              _mutton.text.trim().isEmpty ||
                              _milk.text.trim().isEmpty ||
                              _potato.text.trim().isEmpty ||
                              _vegetables.text.trim().isEmpty ||
                              _rice.text.trim().isEmpty ||
                              _wheat.text.trim().isEmpty ||
                              _nuts.text.trim().isEmpty) {
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
                            SheetsColumn.diet: _diet.text.trim(),
                            SheetsColumn.beef: _beef.text.trim(),
                            SheetsColumn.pork: _pork.text.trim(),
                            SheetsColumn.mutton: _mutton.text.trim(),
                            SheetsColumn.milk: _milk.text.trim(),
                            SheetsColumn.potato: _potato.text.trim(),
                            SheetsColumn.vegetables: _vegetables.text.trim(),
                            SheetsColumn.rice: _rice.text.trim(),
                            SheetsColumn.wheat: _wheat.text.trim(),
                            SheetsColumn.nuts: _nuts.text.trim(),
                          });

                          final feedback = {
                            SheetsColumn.diet: _diet.text.trim(),
                            SheetsColumn.beef: _beef.text.trim(),
                            SheetsColumn.pork: _pork.text.trim(),
                            SheetsColumn.mutton: _mutton.text.trim(),
                            SheetsColumn.milk: _milk.text.trim(),
                            SheetsColumn.potato: _potato.text.trim(),
                            SheetsColumn.vegetables: _vegetables.text.trim(),
                            SheetsColumn.rice: _rice.text.trim(),
                            SheetsColumn.wheat: _wheat.text.trim(),
                            SheetsColumn.nuts: _nuts.text.trim(),
                          };

                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/energy');
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
