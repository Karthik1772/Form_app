import 'package:Formify/core/common/custom_textfield.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/googlesheet.dart'
    as demographic;
import 'package:Formify/features/sheet_pages/transpotation_details/sheets/googlesheet.dart'
    as transport;
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/sheets/googlesheet.dart'
    as environment;
import 'package:Formify/features/sheet_pages/Occupation_details/sheets/googlesheet.dart'
    as occupation;
import 'package:Formify/features/sheet_pages/Food_Consumption/sheets/googlesheet.dart'
    as food;
import 'package:Formify/features/sheet_pages/Energy_Consumption/sheets/googlesheet.dart'
    as energy;
import 'package:Formify/features/sheet_pages/waste_managment/sheets/googlesheet.dart'
    as waste;
import 'package:Formify/features/sheet_pages/Consumer_Choices/sheets/googlesheet.dart'
    as consumer;
import 'package:Formify/features/sheet_pages/Miscellaneous_details/sheets/googlesheet.dart'
    as miscellaneous;
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await demographic.SheetsFlutter.init();
    await transport.SheetsFlutter.init();
    await environment.SheetsFlutter.init();
    await occupation.SheetsFlutter.init();
    await food.SheetsFlutter.init();
    await energy.SheetsFlutter.init();
    await waste.SheetsFlutter.init();
    await consumer.SheetsFlutter.init();
    await miscellaneous.SheetsFlutter.init();
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 90),
            Text(
              "Formify",
              style: GoogleFonts.varelaRound(
                fontSize: 35,
                color: AppColors.white,
              ),
            ),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(180),
              ),
              child: Image.asset("assets/slogo.png"),
            ),
            CustomTextField(
              controller: _email,
              hint: "Enter the email",
              keyboardType: TextInputType.name,
              prefixIconColor: AppColors.white,
              cursor: AppColors.white,
              prefixIcon: Icons.email,
              focused: AppColors.white,
              textcolor: AppColors.white,
              hinttextcolor: AppColors.white,
            ),
            CustomTextField(
              controller: _otp,
              hint: "Enter your otp",
              keyboardType: TextInputType.number,
              isObscure: true,
              prefixIconColor: AppColors.white,
              cursor: AppColors.white,
              prefixIcon: Icons.numbers,
              focused: AppColors.orange,
              textcolor: AppColors.white,
              hinttextcolor: AppColors.white,
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/demographic');
              },
              child: Container(
                height: 40,
                width: 175,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Get Started",
                      style: GoogleFonts.workSans(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 22,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
