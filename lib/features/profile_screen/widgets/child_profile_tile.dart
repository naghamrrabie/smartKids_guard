import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

/// Widget مسؤول عن كارت طفل واحد داخل Children Profiles
class ChildProfileTile extends StatelessWidget {
  const ChildProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافات داخلية للكارت
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

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
          /// صورة الطفل
          ClipOval(
            child: Image.asset(
              ImageAssets.babyPhoto,
              width: 62,
              height: 62,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          /// بيانات الطفل
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eman Ahmed',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Age8 . Modern Future',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),
              ],
            ),
          ),

          /// الجزء اللي على اليمين
          Column(
            children: [
              /// زرار Edit
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.editChildProfile,
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.bluee,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// السهم
              const Icon(
                Icons.chevron_right,
                size: 28,
                color: ColorsManager.greyText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}