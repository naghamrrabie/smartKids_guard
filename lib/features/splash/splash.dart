import 'dart:async'; // متنساش تعمل import لدي عشان الـ Timer
import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      // 1. نقرأ الداتا من الخزنة
      bool? onBoardingSeen = CacheHelper.getData(key: 'onBoarding');
      String? token = CacheHelper.getData(key: 'token');

      // 2. اللوجيك بتاع التوجيه
      if (onBoardingSeen != null && onBoardingSeen == true) {
        // اليوزر شاف الـ Onboarding قبل كده
        if (token != null && token.isNotEmpty) {
          // ومعاه توكن -> يروح الرئيسية
          Navigator.pushReplacementNamed(context, RoutesManager.homeScreen);
        } else {
          // معندوش توكن -> يروح اللوجين
          Navigator.pushReplacementNamed(context, RoutesManager.login);
        }
      } else {
        // أول مرة يفتح الأبلكيشن -> يروح Onboarding
        Navigator.pushReplacementNamed(context, RoutesManager.onBoardingRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: ColorsManager.blue, // تأكد إن الـ Gradient مكتوب صح في ملف الـ Colors
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.SplashLogo),
              const SizedBox(height: 20),
              const Text(
                "Smartkids Guard", // عدلت الـ Spelling بتاع Guard
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: "serif",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}