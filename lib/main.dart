import 'package:demo/features/Demographic_Information/sheets/googlesheet.dart' as Demographic;
import 'package:demo/features/transpotation_details/sheets/googlesheet.dart' as Transport;
import 'package:demo/core/routes/generated_routes.dart';
import 'package:demo/core/themes/app_theme.dart';
import 'package:flutter/material.dart';


void main() async {
  await Demographic.SheetsFlutter.init();
  await Transport.SheetsFlutter.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      onGenerateRoute: Routes.onGenerate,
      initialRoute: "/demographic",
    );
  }
}
