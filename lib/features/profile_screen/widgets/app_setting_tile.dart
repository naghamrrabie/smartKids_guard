import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

/// Widget مسؤول عن كارت App Setting
class AppSettingTile extends StatelessWidget {
  const AppSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافات داخلية للكارت
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [
          /// أيقونة اللغة
          Image.asset(
            ImageAssets.icLanguage,
            width: 40,
            height:40,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 14),

          /// النصوص
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'English (us)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}