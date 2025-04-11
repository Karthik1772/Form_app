import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/common/custom_drop.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/features/sheet_pages/waste_managment/sheets/googlesheet.dart';
import 'package:Formify/features/sheet_pages/waste_managment/sheets/sheetscolumn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Waste extends StatefulWidget {
  const Waste({super.key});

  @override
  State<Waste> createState() => _Waste();
}

class _Waste extends State<Waste> {
  final TextEditingController _power = TextEditingController();
  final TextEditingController _energy = TextEditingController();

  bool _isSubmitted = false;
  bool _next = false;

  @override
  void initState() {
    super.initState();
    final data = FormDataService.instance.getData();
    _power.text = data[SheetsColumn.power] ?? '';
    _energy.text = data[SheetsColumn.energy] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Waste Management",
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
                        dropDownController: _power,
                        hintText: "Do you practice recycling at home?",
                      ),
                      const SizedBox(height: 50),
                      CustomDropDown(
                        list: [
                          "Composting",
                          "Municipal waste collection",
                          "Other",
                        ],
                        dropDownController: _energy,
                        hintText: "How do you manage your organic waste?",
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
                        if (_isSubmitted) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Details already submitted.",
                          );
                          Navigator.pushNamed(context, '/customer');
                          return;
                        }
                        if (_power.text.trim().isEmpty ||
                            _energy.text.trim().isEmpty) {
                          CustomSnackbar.snackbarShow(
                            context,
                            "Please fill all required fields!",
                          );
                          return;
                        }
                        
                        FormDataService.instance.saveData({
                          SheetsColumn.power: _power.text.trim(),
                          SheetsColumn.energy: _energy.text.trim(),
                        });

                        final feedback = {
                          SheetsColumn.power: _power.text.trim(),
                          SheetsColumn.energy: _energy.text.trim(),
                        };

                        await SheetsFlutter.insert(context, [feedback]);
                        setState(() {
                          _isSubmitted = true;
                        });
                        setState(() {
                          _next = true;
                        });
                        if (_next) {
                          Navigator.pushNamed(context, '/customer');
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
    );
  }
}
