import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/features/sheet_pages/Consumer_Choices/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Consumer_Choices/sheets/sheetscolumn.dart';
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
  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _buy.text = data[SheetsColumn.buy] ?? '';
    _reduce.text = data[SheetsColumn.reduce] ?? '';
    _carbon.text = data[SheetsColumn.carbon] ?? '';
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
              "Consumer Details",
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
                      child: CustomButtons(
                        text: "Next",
                        onpressed: () async {
                          if (_buy.text.trim().isEmpty ||
                              _reduce.text.trim().isEmpty ||
                              _carbon.text.trim().isEmpty) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Please fill all required fields!",
                            );
                            return;
                          }

                          FormDataService.instance.saveData({
                            SheetsColumn.buy: _buy.text.trim(),
                            SheetsColumn.reduce: _reduce.text.trim(),
                            SheetsColumn.carbon: _carbon.text.trim(),
                          });

                          final feedback = {
                            SheetsColumn.buy: _buy.text.trim(),
                            SheetsColumn.reduce: _reduce.text.trim(),
                            SheetsColumn.carbon: _carbon.text.trim(),
                          };

                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/miscellaneous');
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
