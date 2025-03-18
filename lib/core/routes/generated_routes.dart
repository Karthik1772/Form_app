import 'package:demo/features/Consumer_Choices/customer.dart';
import 'package:demo/features/Demographic_Information/Demographic.dart';
import 'package:demo/features/Energy_Consumption/energy.dart';
import 'package:demo/features/Environmentally%20Awareness/Environment.dart';
import 'package:demo/features/Food_Consumption/Food.dart';
import 'package:demo/features/Miscellaneous_details/Miscellaneous.dart';
import 'package:demo/features/Occupation_details/Occupation.dart';
import 'package:demo/features/transpotation_details/transportation.dart';
import 'package:demo/features/waste_managment/waste.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
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
    }
    return null;
  }
}
