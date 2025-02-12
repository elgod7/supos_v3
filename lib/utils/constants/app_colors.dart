import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color.fromRGBO(81, 78, 182, 1);
  static const Color lightColor = Color.fromARGB(255, 255, 255, 255);
  static const Color darkColor = Color.fromRGBO(39, 38, 49, 1);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color(0xff0C1C2E);
  static MaterialColor primarySwatch = MaterialColor(
    primaryColor.value,
    <int, Color>{
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    },
  );

  static const List<Color> defaultGradient = [
    lightColor,
    darkerBlue,
    darkestBlue,
  ];
}
