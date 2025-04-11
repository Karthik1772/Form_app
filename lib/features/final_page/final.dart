import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}
  
class _FinalPageState extends State<FinalPage> {
  @override
  void initState() {
    super.initState();
    FormDataService.instance.clearData(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.orange,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.white),
                  borderRadius: BorderRadius.circular(180),
                ),
                child: Lottie.asset('assets/success.json'),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                ),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      "Your Response has been recorded",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.varelaRound(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Thank you for your response",
                      style: GoogleFonts.varelaRound(
                        fontSize: 20,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/splash');
                },
                child: Container(
                  height: 50,
                  // width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Submit Another Response",
                        style: GoogleFonts.workSans(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
