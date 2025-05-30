import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_loading.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
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
  bool _isLoading = false;

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
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Consumer Details",
              style: GoogleFonts.varelaRound(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
            ),
          ),
          body: Stack(
            children: [
              Padding(
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
                            buttoncolor: AppColors.orange,
                            textcolor: AppColors.white,
                            fontsize: 20,
                            text: "Next",
                            onpressed: () async {
                              if (_buy.text.trim().isEmpty ||
                                  _reduce.text.trim().isEmpty ||
                                  _carbon.text.trim().isEmpty) {
                                CustomSnackbar.show(
                                  context: context,
                                  text: "Please fill all required fields!",
                                  background: AppColors.orange,
                                  textcolor: AppColors.white,
                                  position: 50,
                                );
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              try {
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
                                  Navigator.pushNamed(
                                    context,
                                    '/miscellaneous',
                                  );
                                }
                              } catch (e) {
                                setState(() {
                                  _isLoading = false;
                                });
                                CustomSnackbar.show(
                                  context: context,
                                  text:
                                      "Error submitting data: ${e.toString()}",
                                  background: Colors.red,
                                  textcolor: AppColors.white,
                                  position: 50,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              if (_isLoading)
                CustomLoading(
                  message: "Submitting data...",
                  backgroundColor: AppColors.orange,
                  textColor: AppColors.white,
                  indicatorColor: AppColors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
