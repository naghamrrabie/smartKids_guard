import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../../core/resources/assets_manager.dart';

/// =======================================================
/// Widget مسؤول عن الجزء العلوي في الشاشة (Header)
/// هنا خلّينا ارتفاع الهيدر dynamic
/// عشان مايحصلش overflow على الأجهزة المختلفة
/// =======================================================
class HomeHeader extends StatelessWidget {
  /// Constructor عادي لأن الـ widget ثابتة ومفيهاش بيانات متغيرة
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    /// ===================================================
    /// ده ارتفاع الـ status bar / النوتش
    /// بيختلف من جهاز لجهاز
    /// ===================================================
    final double topInset = MediaQuery.of(context).padding.top;

    return Container(
      /// ===================================================
      /// بدل height ثابت
      /// خليناه:
      /// ارتفاع المحتوى + ارتفاع الـ status bar
      /// عشان مايحصلش overflow
      /// ===================================================
      height: topInset + 150,

      /// يخلي الهيدر ياخد عرض الشاشة كله
      width: double.infinity,

      /// شكل الهيدر الخارجي
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,

        /// تقويس الحواف السفلية فقط
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(55),
          bottomRight: Radius.circular(55),
        ),

        /// ظل خفيف تحت الهيدر
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      /// ===================================================
      /// SafeArea هنا فقط
      /// bottom: false معناها نحمي من فوق فقط
      /// ===================================================
      child: SafeArea(
        bottom: false,
        child: Padding(
          /// مسافة داخلية بين حدود الهيدر والمحتوى اللي جواه
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),

          /// عناصر الهيدر مرتبة عموديًا
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// الصف العلوي: أيقونة Notification + أيقونة Settings
              Row(
                children: const [
                  Spacer(),
                  _CircleIconButton(asset: ImageAssets.icNotification),
                  SizedBox(width: 12),
                  _CircleIconButton(asset: ImageAssets.icSetting),
                ],
              ),

              const SizedBox(height: 10),

              /// النص الرئيسي
              const Text(
                'Hello, Parent 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 2),

              /// النص الثانوي
              Text(
                'Your family is safe today',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.92),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// Widget صغير مسؤول عن الأيقونات الدائرية داخل الهيدر
/// =======================================================
class _CircleIconButton extends StatelessWidget {
  /// مسار الأيقونة من الـ assets
  final String asset;

  /// Constructor لاستقبال مسار الصورة
  const _CircleIconButton({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// عرض الدائرة
      width: 40,

      /// ارتفاع الدائرة
      height: 40,

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        shape: BoxShape.circle,
      ),

      child: Center(
        child: Image.asset(
          asset,
          width: 20,
          height: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}