import 'package:Formify/core/common/custom_textfield.dart';
import 'package:Formify/core/common/custom_buttons.dart';
import 'package:Formify/core/models/form_data_service.dart';
import 'package:Formify/core/themes/app_colors.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/sheetscolumn.dart';
import 'package:Formify/features/splash_screen/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/googlesheet.dart' as demographic;
import 'package:Formify/features/sheet_pages/transpotation_details/sheets/googlesheet.dart' as transport;
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/sheets/googlesheet.dart' as environment;
import 'package:Formify/features/sheet_pages/Occupation_details/sheets/googlesheet.dart' as occupation;
import 'package:Formify/features/sheet_pages/Food_Consumption/sheets/googlesheet.dart' as food;
import 'package:Formify/features/sheet_pages/Energy_Consumption/sheets/googlesheet.dart' as energy;
import 'package:Formify/features/sheet_pages/waste_managment/sheets/googlesheet.dart' as waste;
import 'package:Formify/features/sheet_pages/Consumer_Choices/sheets/googlesheet.dart' as consumer;
import 'package:Formify/features/sheet_pages/Miscellaneous_details/sheets/googlesheet.dart' as miscellaneous;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Formify/core/common/custom_snackbar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  bool _otpSent = false;

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context) => OtpBloc(),
            child: BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) async {
                if (state is OtpSendSuccess) {
                  CustomSnackbar.show(
                    context: context,
                    text: state.message,
                    background: AppColors.white,
                    textcolor: AppColors.orange,
                    position: 70,
                  );
                  setState(() {
                    _otpSent = true;
                  });
                } else if (state is OtpSendFailure) {
                  CustomSnackbar.show(
                    context: context,
                    text: state.error,
                    background: AppColors.white,
                    textcolor: AppColors.orange,
                    position: 50,
                  );
                } else if (state is OtpVerifySuccess) {
                  FormDataService.instance.saveData({
                    SheetsColumn.email: _email.text.trim(),
                  });
                  Navigator.pushNamed(context, '/demographic');
                } else if (state is OtpVerifyFailure) {
                  CustomSnackbar.show(
                    context: context,
                    text: state.error,
                    background: AppColors.white,
                    textcolor: AppColors.orange,
                    position: 50,
                  );
                }
              },
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: AppColors.orange,
                  body: SingleChildScrollView(
                    child: SizedBox(
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
                            SizedBox(height: 70),
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
                                isotpField: true,
                                suffixIconColor: AppColors.white,
                              ),
                            SizedBox(height: 150),
                            _otpSent
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CustomButtons(
                                          text: state is OtpLoading ? "Verifying..." : "Verify OTP",
                                          isLoading: state is OtpLoading,
                                          buttoncolor: AppColors.white,
                                          textcolor: AppColors.orange,
                                          loadingcolor: AppColors.white,
                                          fontsize: 18,
                                          onpressed: () {
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
                                      ),
                                      Expanded(
                                        child: CustomButtons(
                                          text: state is OtpLoading ? "Resending..." : "Resend OTP",
                                          isLoading: state is OtpLoading,
                                          buttoncolor: AppColors.white,
                                          textcolor: AppColors.orange,
                                          loadingcolor: AppColors.white,
                                          fontsize: 18,
                                          onpressed: () {
                                            if (state is! OtpLoading) {
                                              context.read<OtpBloc>().add(
                                                    ResendOtpRequested(
                                                      email: _email.text.trim(),
                                                    ),
                                                  );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 60),
                                    child: CustomButtons(
                                      text: state is OtpLoading ? "Sending..." : "Send OTP",
                                      isLoading: state is OtpLoading,
                                      buttoncolor: AppColors.white,
                                      textcolor: AppColors.orange,
                                      loadingcolor: AppColors.white,
                                      fontsize: 20,
                                      onpressed: () {
                                        if (state is! OtpLoading) {
                                          context.read<OtpBloc>().add(
                                                SendOtpRequested(email: _email.text.trim()),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                            SizedBox(height: 10),
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
}
