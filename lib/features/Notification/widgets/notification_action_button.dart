import 'package:flutter/material.dart';

/// =======================================================
/// Widget مسؤول عن زرار View details
/// الزرار ده بيتكرر في بعض كروت التحذير
/// =======================================================
class NotificationActionButton extends StatelessWidget {
  /// الدالة اللي هتشتغل لما المستخدم يضغط على الزرار
  final VoidCallback? onTap;

  const NotificationActionButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// لما المستخدم يضغط على الزرار
      onTap: onTap,

      /// ده بيخلي تأثير الضغط ياخد نفس شكل الزرار
      borderRadius: BorderRadius.circular(16),

      child: Container(
        /// عرض الزرار
        width: 145,

        /// ارتفاع الزرار
        height: 48,

        /// شكل الزرار
        decoration: BoxDecoration(
          color: const Color(0xFFE24022),
          borderRadius: BorderRadius.circular(16),
        ),

        /// النص اللي جوه الزرار
        child: const Center(
          child: Text(
            'View details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}