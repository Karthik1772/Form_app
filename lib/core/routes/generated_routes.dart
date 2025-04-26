import 'package:Formify/features/final_page/final.dart';
import 'package:Formify/features/sheet_pages/Consumer_Choices/customer.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/Demographic.dart';
import 'package:Formify/features/sheet_pages/Energy_Consumption/energy.dart';
import 'package:Formify/features/sheet_pages/Environmentally_Awareness/Environment.dart';
import 'package:Formify/features/sheet_pages/Food_Consumption/Food.dart';
import 'package:Formify/features/sheet_pages/Miscellaneous_details/Miscellaneous.dart';
import 'package:Formify/features/sheet_pages/Occupation_details/Occupation.dart';
import 'package:Formify/features/sheet_pages/transpotation_details/transportation.dart';
import 'package:Formify/features/sheet_pages/waste_managment/waste.dart';
import 'package:Formify/features/splash_screen/pages/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (context) => Splash());
      case "/demographic":
        return MaterialPageRoute(builder: (context) => Demographic());
      case "/transportation":
        return MaterialPageRoute(builder: (context) => Transportation());
      case "/environment":
        return MaterialPageRoute(builder: (context) => Environment());
      case "/occupation":
        return MaterialPageRoute(builder: (context) => Occupation());
      case "/food":
        return MaterialPageRoute(builder: (context) => Food());
      case "/energy":
        return MaterialPageRoute(builder: (context) => Energy());
      case "/waste":
        return MaterialPageRoute(builder: (context) => Waste());
      case "/customer":
        return MaterialPageRoute(builder: (context) => Customer());
      case "/miscellaneous":
        return MaterialPageRoute(builder: (context) => Miscellaneous());
      case "/final":
        return MaterialPageRoute(builder: (context) => FinalPage());
    }
    return null;
  }
}
