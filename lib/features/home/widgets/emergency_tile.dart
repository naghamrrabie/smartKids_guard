import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

/// Widget مسؤول عن كارت واحد من كروت Emergency Contacts
class EmergencyTile extends StatelessWidget {
  /// مسار الأيقونة من الـ assets
  final String iconAsset;

  /// عنوان الجهة أو المكان
  final String title;

  /// رقم الهاتف
  final String phone;

  /// Constructor لاستقبال البيانات المطلوبة لكل كارت
  const EmergencyTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية بين حدود الكارت والمحتوى اللي جواه
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

      /// شكل الكارت الخارجي
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      /// محتوى الكارت: أيقونة - نصوص - أيقونة الاتصال
      child: Row(
        children: [
          /// الأيقونة فقط بدون خلفية دائرية
          Image.asset(
            iconAsset,
            width: 43,
            height: 43,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 12),

          /// النصوص تاخد باقي المساحة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// اسم الجهة
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),

                /// رقم الهاتف
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),
              ],
            ),
          ),

          /// أيقونة الاتصال
          const Icon(
            Icons.call,
            color: Color(0xFF1DB954),
            size: 28,
          ),
        ],
      ),
    );
  }
}