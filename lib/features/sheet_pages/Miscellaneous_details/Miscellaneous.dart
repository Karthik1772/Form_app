import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_loading.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/sheet_pages/Miscellaneous_details/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Miscellaneous_details/sheets/sheetscolumn.dart';
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

  bool _next = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _flight.text = data[SheetsColumn.flight] ?? '';
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
              "Miscellaneous details",
              style: GoogleFonts.varelaRound(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtons(
                            text: "Submit",
                            fontsize: 20,
                            buttoncolor: AppColors.orange,
                            textcolor: AppColors.white,
                            onpressed: () async {
                              if (_flight.text.trim().isEmpty ||
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
                                  SheetsColumn.flight: _flight.text.trim(),
                                  SheetsColumn.carbon: _carbon.text.trim(),
                                });
                                final feedback = {
                                  SheetsColumn.flight: _flight.text.trim(),
                                  SheetsColumn.carbon: _carbon.text.trim(),
                                };

                                await SheetsFlutter.insert(context, [feedback]);
                                setState(() {
                                  _next = true;
                                });
                                if (_next) {
                                  Navigator.pushNamed(context, '/final');
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
