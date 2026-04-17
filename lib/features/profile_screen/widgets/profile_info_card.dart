import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

/// Widget مسؤول عن كارت بيانات المستخدم
class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافات داخلية للكارت
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            children: [
              /// صورة البروفايل
              ClipOval(
                child: Image.asset(
                  ImageAssets.imageProfile,
                  width: 78,
                  height: 78,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),

              /// بيانات المستخدم
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mona Mohamed',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'monamohamed23@example.com',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.greyText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '01023564685',
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

          const SizedBox(height: 22),

          /// زرار Edit Profile
          InkWell(
            onTap: () {
              /// افتح شاشة Edit Profile من الـ routes
              Navigator.pushNamed(context, RoutesManager.editProfileScreen);
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: ColorsManager.blue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}