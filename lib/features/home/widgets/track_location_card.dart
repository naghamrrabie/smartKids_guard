import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../../core/resources/assets_manager.dart';

/// Widget مسؤول عن كارت Track Location
class TrackLocationCard extends StatelessWidget {
  /// Constructor عادي لأن الـ widget ثابتة ومفيهاش بيانات متغيرة
  const TrackLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية بين حدود الكارت والمحتوى اللي جواه
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      /// شكل الكارت الخارجي
      decoration: BoxDecoration(
        color: Colors.white, // لون خلفية الكارت
        borderRadius: BorderRadius.circular(16), // تقويس الحواف

        /// ظل للكارت عشان يبان منفصل عن الخلفية
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      /// محتوى الكارت جواه صف أفقي:
      /// أيقونة على الشمال + نصوص على اليمين
      child: Row(
        children: [
          /// أيقونة Track Location من الـ assets
          Image.asset(
            ImageAssets.icTrackLocation,
            width: 50, // عرض الأيقونة
            height: 50, // ارتفاع الأيقونة
            fit: BoxFit.contain, // يخلي الصورة تظهر كاملة بدون قص
          ),

          /// مسافة بين الأيقونة والنص
          const SizedBox(width: 12),

          /// النصوص اللي على يمين الأيقونة
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              /// العنوان الرئيسي
              Text(
                'Track Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              /// مسافة صغيرة بين العنوان والوصف
              SizedBox(height: 1),

              /// النص الثانوي
              Text(
                'View on map',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}