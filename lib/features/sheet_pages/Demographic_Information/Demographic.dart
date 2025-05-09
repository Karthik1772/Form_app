import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_loading.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/common/custom_textfield.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Demographic extends StatefulWidget {
  const Demographic({super.key});

  @override
  State<Demographic> createState() => _DemographicState();
}

class _DemographicState extends State<Demographic> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _occupation = TextEditingController();

  bool _next = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final data = FormDataService.instance.getData();
    setState(() {
      _name.text = data[SheetsColumn.name] ?? '';
      _email.text = data[SheetsColumn.email] ?? '';
      _age.text = data[SheetsColumn.age] ?? '';
      _gender.text = data[SheetsColumn.gender] ?? '';
      _location.text = data[SheetsColumn.location] ?? '';
      _occupation.text = data[SheetsColumn.occupation] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              "Demographic Details",
              style: GoogleFonts.varelaRound(
                fontSize: 24,
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
                          children: [
                            CustomTextField(
                              controller: _name,
                              hint: "Name",
                              cursor: AppColors.orange,
                              textcolor: AppColors.orange,
                              prefixIcon: Icons.abc,
                              prefixIconColor: AppColors.orange,
                              focused: AppColors.orange,
                              hinttextcolor: AppColors.lightorange,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 50),
                            CustomTextField(
                              controller: _email,
                              isEnabled: false,
                              keyboardType: TextInputType.name,
                              textcolor: AppColors.orange,
                              hint: "Email",
                              prefixIconColor: AppColors.orange,
                              hinttextcolor: AppColors.lightorange,
                              cursor: AppColors.orange,
                              prefixIcon: Icons.email,
                              focused: AppColors.orange,
                            ),
                            const SizedBox(height: 50),
                            CustomDropDown(
                              list: [
                                "18-24",
                                "25-34",
                                "35-44",
                                "45-54",
                                "55 and above",
                              ],
                              dropDownController: _age,
                              hintText: 'Age',
                            ),
                            const SizedBox(height: 50),
                            CustomDropDown(
                              list: [
                                "Male",
                                "Female",
                                "Non-Binary",
                                "Prefer not to say",
                              ],
                              dropDownController: _gender,
                              hintText: "Gender",
                            ),
                            const SizedBox(height: 50),
                            CustomDropDown(
                              list: ["Urban", "SubUrban", "Rural"],
                              dropDownController: _location,
                              hintText: "Location",
                            ),
                            const SizedBox(height: 50),
                            CustomDropDown(
                              list: [
                                "Employed",
                                "Student",
                                "Homemaker",
                                "Unemployed",
                                "Other",
                              ],
                              dropDownController: _occupation,
                              hintText: "Occupation",
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
                            fontsize: 20,
                            buttoncolor: AppColors.orange,
                            textcolor: AppColors.white,
                            onpressed: () async {
                              if (_name.text.trim().isEmpty ||
                                  _email.text.trim().isEmpty ||
                                  _age.text.trim().isEmpty ||
                                  _gender.text.trim().isEmpty ||
                                  _location.text.trim().isEmpty ||
                                  _occupation.text.trim().isEmpty) {
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
                                  SheetsColumn.name: _name.text.trim(),
                                  SheetsColumn.email: _email.text.trim(),
                                  SheetsColumn.age: _age.text.trim(),
                                  SheetsColumn.gender: _gender.text.trim(),
                                  SheetsColumn.location: _location.text.trim(),
                                  SheetsColumn.occupation:
                                      _occupation.text.trim(),
                                });
                                final feedback = {
                                  SheetsColumn.name: _name.text.trim(),
                                  SheetsColumn.email: _email.text.trim(),
                                  SheetsColumn.age: _age.text.trim(),
                                  SheetsColumn.gender: _gender.text.trim(),
                                  SheetsColumn.location: _location.text.trim(),
                                  SheetsColumn.occupation:
                                      _occupation.text.trim(),
                                };

                                await SheetsFlutter.insert(context, [feedback]);
                                setState(() {
                                  _next = true;
                                });
                                if (_next) {
                                  Navigator.pushNamed(
                                    context,
                                    '/transportation',
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
