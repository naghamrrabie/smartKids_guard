import 'package:flutter/material.dart';

/// =======================================================
/// Widget مسؤول عن الزرار الصغير اللي فوق
/// زي:
/// - All(6)
/// - Warning(1)
/// =======================================================
class NotificationFilterChip extends StatelessWidget {
  /// النص اللي هيظهر داخل الزرار
  final String title;

  /// هل الزرار ده هو المختار حاليًا ولا لا
  final bool isSelected;

  /// دالة بتتنفذ لما المستخدم يضغط على الزرار
  final VoidCallback onTap;

  const NotificationFilterChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /// لما المستخدم يضغط على الزرار
      onTap: onTap,

      /// عشان تأثير الضغط يبقى بنفس شكل الكابسولة
      borderRadius: BorderRadius.circular(18),

      child: Container(
        /// مسافات داخلية للزرار
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

        /// شكل الزرار
        decoration: BoxDecoration(
          /// لو الزرار مختار نخلي اللون أوضح شوية
          color: Colors.white.withOpacity(isSelected ? 0.35 : 0.22),
          borderRadius: BorderRadius.circular(18),
        ),

        /// النص اللي جوه الزرار
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}