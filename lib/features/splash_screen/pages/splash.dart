import 'package:Formify/core/common/custom_textfield.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/splash_screen/bloc/otp_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Formify/core/common/custom_snackbar.dart';

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
  bool _otpSent = false;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSendSuccess) {
            CustomSnackbar.snackbarShow(context, state.message);
            setState(() {
              _otpSent = true;
            });
          } else if (state is OtpSendFailure) {
            CustomSnackbar.snackbarShow(context, state.error);
          } else if (state is OtpVerifySuccess) {
            Navigator.pushNamed(context, '/demographic');
          } else if (state is OtpVerifyFailure) {
            CustomSnackbar.snackbarShow(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.orange,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 60),
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
                      
                      // Email field
                      CustomTextField(
                        controller: _email,
                        hint: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIconColor: AppColors.white,
                        cursor: AppColors.white,
                        prefixIcon: Icons.email,
                        focused: AppColors.white,
                        textcolor: AppColors.white,
                        hinttextcolor: AppColors.white,
                      ),
                      
                      // OTP Input field appears after OTP is sent
                      if (_otpSent)
                        CustomTextField(
                          controller: _otp,
                          hint: "Enter your OTP",
                          keyboardType: TextInputType.number,
                          isObscure: true,
                          prefixIconColor: AppColors.white,
                          cursor: AppColors.white,
                          prefixIcon: Icons.numbers,
                          focused: AppColors.white,
                          textcolor: AppColors.white,
                          hinttextcolor: AppColors.white,
                        ),
                      
                      // Action buttons
                      _otpSent 
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Verify OTP button
                              _buildButton(
                                context: context,
                                label: state is OtpLoading ? "Verifying..." : "Verify OTP",
                                icon: Icons.check_circle_outline,
                                isLoading: state is OtpLoading,
                                onTap: () {
                                  if (state is! OtpLoading) {
                                    context.read<OtpBloc>().add(
                                      VerifyOtpRequested(
                                        email: _email.text.trim(),
                                        otp: _otp.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(width: 16),
                              // Resend OTP button
                              _buildButton(
                                context: context,
                                label: state is OtpLoading ? "Resending..." : "Resend OTP",
                                icon: Icons.refresh,
                                isLoading: state is OtpLoading,
                                onTap: () {
                                  if (state is! OtpLoading) {
                                    context.read<OtpBloc>().add(
                                      ResendOtpRequested(email: _email.text.trim()),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        : _buildButton(
                            context: context,
                            label: state is OtpLoading ? "Sending..." : "Send OTP",
                            icon: Icons.send,
                            isLoading: state is OtpLoading,
                            onTap: () {
                              if (state is! OtpLoading) {
                                context.read<OtpBloc>().add(
                                  SendOtpRequested(email: _email.text.trim()),
                                );
                              }
                            },
                            width: 175,
                          ),
                      
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isLoading,
    double width = 140,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            else
              Text(
                label,
                style: GoogleFonts.workSans(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            SizedBox(width: 8),
            if (!isLoading)
              Icon(
                icon,
                size: 20,
                color: AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}