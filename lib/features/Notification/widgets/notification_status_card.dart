import 'package:flutter/material.dart';

      /// Widget مسؤول عن كارت الحالة الآمنة
/// زي:
      /// - Safe Arrival
      /// - Safe Departure
      /// ============================================
class NotificationStatusCard extends StatelessWidget {
  /// مسار الأيقونة من الـ assets
  final String iconAsset;

  /// عنوان الكارت
  final String title;

  /// النص التوضيحي
  final String subtitle;

  const NotificationStatusCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافات داخلية للكارت
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        /// البوردر الأزرق
        border: Border.all(
          color: const Color(0xFFC6DBF4),
          width: 1.2,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الأيقونة
          Image.asset(
            iconAsset,
            width: 44,
            height: 44,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 14),

          /// النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// عنوان الكارت
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                /// النص التوضيحي
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6F6F6F),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// النقطة الزرقا
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Color(0xFF4A90E2),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}