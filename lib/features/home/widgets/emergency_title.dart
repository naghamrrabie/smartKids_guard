import 'package:flutter/material.dart';
import '../../../core/resources/assets_manager.dart';

/// Widget مسؤول عن عنوان قسم Emergency Contacts
class EmergencyTitle extends StatelessWidget {
  /// Constructor عادي لأن الـ widget ثابتة ومفيهاش بيانات متغيرة
  const EmergencyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// أيقونة الـ emergency من الـ assets
        Image.asset(
          ImageAssets.icEmergency,
          width: 20, // عرض الأيقونة
          height: 20, // ارتفاع الأيقونة
          fit: BoxFit.contain, // يخلي الصورة تظهر كاملة بدون قص
        ),

        /// مسافة بسيطة بين الأيقونة والنص
        const SizedBox(width: 8),

        /// عنوان القسم
        const Text(
          'Emergency Contacts',
          style: TextStyle(
            fontSize: 15, // حجم الخط
            fontWeight: FontWeight.w600, // سمك الخط
            color: Colors.black, // لون النص
          ),
        ),
      ],
    );
  }
}