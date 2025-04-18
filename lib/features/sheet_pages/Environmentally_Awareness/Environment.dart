import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Environment extends StatefulWidget {
  const Environment({super.key});

  @override
  State<Environment> createState() => _Environment();
}

class _Environment extends State<Environment> {
  final TextEditingController _garden = TextEditingController();
  final TextEditingController _aprogram = TextEditingController();
  final TextEditingController _trend = TextEditingController();

  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _garden.text = data[SheetsColumn.garden] ?? '';
    _aprogram.text = data[SheetsColumn.aprogram] ?? '';
    _trend.text = data[SheetsColumn.trend] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Environmental Awareness",
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
                          list: ["Yes", "No"],
                          dropDownController: _garden,
                          hintText: "Do you do gardening",
                        ),
                        const SizedBox(height: 50),
                        CustomDropDown(
                          list: ["Yes", "No"],
                          dropDownController: _aprogram,
                          hintText: "Do you attends awareness programs",
                        ),
                        const SizedBox(height: 50),
                        CustomDropDown(
                          list: ["Yes", "No"],
                          dropDownController: _trend,
                          hintText:
                              'Are you aware of trending sustainable features',
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
                          if (_garden.text.trim().isEmpty ||
                              _aprogram.text.trim().isEmpty ||
                              _trend.text.trim().isEmpty) {
                            CustomSnackbar.snackbarShow(
                              context,
                              "Please fill all required fields!",
                            );
                            return;
                          }
                          FormDataService.instance.saveData({
                            SheetsColumn.garden: _garden.text.trim(),
                            SheetsColumn.aprogram: _aprogram.text.trim(),
                            SheetsColumn.trend: _trend.text.trim(),
                          });
                          final feedback = {
                            SheetsColumn.garden: _garden.text.trim(),
                            SheetsColumn.aprogram: _aprogram.text.trim(),
                            SheetsColumn.trend: _trend.text.trim(),
                          };

                          await SheetsFlutter.insert(context, [feedback]);
                          setState(() {
                            _next = true;
                          });
                          if (_next) {
                            Navigator.pushNamed(context, '/occupation');
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
