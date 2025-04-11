import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/common/custom_textfield.dart';
import 'package:Formify/core/models/form_data_service.dart';
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

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _name.text = data[SheetsColumn.name] ?? '';
    _email.text = data[SheetsColumn.email] ?? '';
    _age.text = data[SheetsColumn.age] ?? '';
    _gender.text = data[SheetsColumn.gender] ?? '';
    _location.text = data[SheetsColumn.location] ?? '';
    _occupation.text = data[SheetsColumn.occupation] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
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
                      children: [
                        CustomTextField(controller: _name, hint: "Name"),
                        const SizedBox(height: 50),
                        CustomTextField(controller: _email, hint: "Email"),
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
                        onpressed: () async {
                          if (_name.text.trim().isEmpty ||
                              _email.text.trim().isEmpty ||
                              _age.text.trim().isEmpty ||
                              _gender.text.trim().isEmpty ||
                              _location.text.trim().isEmpty ||
                              _occupation.text.trim().isEmpty) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Please fill all required fields!",
                            );
                            return;
                          }
      
                          final existing = await SheetsFlutter.checkIfEmailExists(
                            _email.text.trim(),
                          );
                          if (existing) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Details already submitted from this email.",
                            );
                            return;
                          }
      
                          FormDataService.instance.saveData({
                            SheetsColumn.name: _name.text.trim(),
                            SheetsColumn.email: _email.text.trim(),
                            SheetsColumn.age: _age.text.trim(),
                            SheetsColumn.gender: _gender.text.trim(),
                            SheetsColumn.location: _location.text.trim(),
                            SheetsColumn.occupation: _occupation.text.trim(),
                          });
                          final feedback = {
                            SheetsColumn.name: _name.text.trim(),
                            SheetsColumn.email: _email.text.trim(),
                            SheetsColumn.age: _age.text.trim(),
                            SheetsColumn.gender: _gender.text.trim(),
                            SheetsColumn.location: _location.text.trim(),
                            SheetsColumn.occupation: _occupation.text.trim(),
                          };
      
                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/transportation');
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
        ),
      ),
    );
  }
}
