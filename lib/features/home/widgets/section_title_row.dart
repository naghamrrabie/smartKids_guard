import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

/// Widget مسؤول عن صف عنوان القسم
/// مثال:
/// - Children Status        Add Child
class SectionTitleRow extends StatelessWidget {
  /// النص اللي هيظهر على الشمال
  final String left;

  /// النص اللي هيظهر على اليمين
  final String right;

  /// دالة بتتنفذ لما المستخدم يضغط على النص اللي على اليمين
  final VoidCallback? onRightTap;

  const SectionTitleRow({
    super.key,
    required this.left,
    required this.right,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// النص اللي على الشمال
        Text(
          left,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        /// Spacer بيدفع العنصر اللي بعده لأقصى اليمين
        const Spacer(),

        /// النص اللي على اليمين
        GestureDetector(
          onTap: onRightTap,
          child: Text(
            right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.bluee,
            ),
          ),
        ),
      ],
    );
  }
}