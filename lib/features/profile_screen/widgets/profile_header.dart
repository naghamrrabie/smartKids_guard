import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'menu.dart';

/// =======================================================
/// Widget مسؤول عن الهيدر العلوي في صفحة Profile
/// الهيدر ده بيعرض:
/// - زرار الرجوع
/// - عنوان الصفحة
/// - زرار الإعدادات
///
/// هنا حلّينا مشكلة الفراغ اللي فوق الهيدر
/// عن طريق استخدام SafeArea جوه الهيدر نفسه
/// =======================================================
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر
      /// زودناه شوية عشان يستوعب الـ status bar + المحتوى
      height: 130,

      /// ياخد عرض الشاشة كله
      width: double.infinity,

      /// شكل الهيدر
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
      ),

      /// ===================================================
      /// SafeArea هنا فقط
      /// bottom: false معناها نحمي من فوق فقط
      /// عشان الأيقونات والعنوان ما يدخلوش تحت الـ status bar
      /// ===================================================
      child: SafeArea(
        bottom: false,
        child: Padding(
          /// مسافات داخلية للمحتوى جوه الهيدر
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              /// =========================================
              /// زرار الرجوع
              /// =========================================
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28,
                ),
              ),

              const SizedBox(width: 6),

              /// =========================================
              /// عنوان الصفحة
              /// Expanded عشان ياخد باقي المساحة
              /// =========================================
              const Expanded(
                child: Text(
                  'Profile&Setting',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),

              /// =========================================
              /// زرار الإعدادات
              /// لما المستخدم يضغط عليه يفتح MenuScreen كـ dialog
              /// =========================================
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (_) => const MenuScreen(),
                  );
                },
                icon: Image.asset(
                  ImageAssets.rivetIconsSettings,
                  width: 26,
                  height: 26,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}