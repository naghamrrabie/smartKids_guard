import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

/// Widget مسؤول عن زرار Log Out
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.login,
              (route) => false,
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        /// ارتفاع الزرار
        height: 56,

        /// شكل الزرار
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: ColorsManager.bluee,
            width: 1.5,
          ),
        ),

        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// أيقونة تسجيل الخروج
            Icon(
              Icons.logout,
              color: ColorsManager.bluee,
              size: 26,
            ),
            SizedBox(width: 10),

            /// نص الزرار
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorsManager.bluee,
              ),
            ),
          ],
        ),
      ),
    );
  }
}