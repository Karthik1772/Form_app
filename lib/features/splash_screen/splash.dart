import 'package:Formify/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/googlesheet.dart'
    as Demographic;
import 'package:Formify/features/sheet_pages/transpotation_details/sheets/googlesheet.dart'
    as Transport;
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/sheets/googlesheet.dart'
    as Environment;
import 'package:Formify/features/sheet_pages/Occupation_details/sheets/googlesheet.dart'
    as Occupation;
import 'package:Formify/features/sheet_pages/Food_Consumption/sheets/googlesheet.dart'
    as Food;
import 'package:Formify/features/sheet_pages/Energy_Consumption/sheets/googlesheet.dart'
    as Energy;
import 'package:Formify/features/sheet_pages/waste_managment/sheets/googlesheet.dart'
    as Waste;
import 'package:Formify/features/sheet_pages/Consumer_Choices/sheets/googlesheet.dart'
    as Consumer;
import 'package:Formify/features/sheet_pages/Miscellaneous_details/sheets/googlesheet.dart'
    as Miscellaneous;
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
    await Demographic.SheetsFlutter.init();
    await Transport.SheetsFlutter.init();
    await Environment.SheetsFlutter.init();
    await Occupation.SheetsFlutter.init();
    await Food.SheetsFlutter.init();
    await Energy.SheetsFlutter.init();
    await Waste.SheetsFlutter.init();
    await Consumer.SheetsFlutter.init();
    await Miscellaneous.SheetsFlutter.init();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 50),
            Text(
              "Formify",
              style: GoogleFonts.varelaRound(
                fontSize: 30,
                color: AppColors.white,
              ),
            ),
            Container(
              width: 150,
              height: 150,
              child: Icon(Icons.person, color: AppColors.white, size: 120),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(90),
              ),
            ),
            SizedBox(height: 350),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/demographic');
              },
              child: Container(
                height: 35,
                width: 150,
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
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
