import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
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
      canPop:false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
                        onpressed: () async {
                          if (_flight.text.trim().isEmpty ||
                              _carbon.text.trim().isEmpty) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Please fill all required fields!",
                            );
                            return;
                          }
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
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
