import 'package:flutter/material.dart';

class ColorsManager{
  static const LinearGradient blue = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFA0CBFC), // 0%
      Color(0xFF2B69EC), // 46%
      Color(0xFF2563EB), // 82%
    ],
    stops: [
      0.0,
      0.50,
      1.0,
    ],
  );
  static const Color lightBlue = Color(0xFFEDF8FF);
  static const Color bluee = Color(0xFF4F92F6);
  static const Color greyText = Color(0xFF9E9E9E);
  static const Color greyBorder = Color(0xFFE0E0E0);
  static const Color greyBackground = Color(0xFFE2E0E1);
  static const Color primary = Color(0xFF404040);
  static const Color darkYellow = Color(0xFFF9A825);
  static const Color lightYellow = Color(0xFFFFF5E5);

}
