import 'package:flutter/material.dart';
import 'notification_filter_chip.dart';

/// =======================================================
/// Widget مسؤول عن صف الفلاتر اللي فوق
/// فيه:
/// - All(6)
/// - Warning(1)
///
/// وظيفته:
/// - يعرض الزرين
/// - يحدد مين المختار
/// - يبعت الضغطات للشاشة الأساسية
/// =======================================================
class NotificationFilterRow extends StatelessWidget {
  /// هل زرار All هو المختار حاليًا؟
  final bool isAllSelected;

  /// دالة بتتنفذ لما المستخدم يضغط على All
  final VoidCallback onTapAll;

  /// دالة بتتنفذ لما المستخدم يضغط على Warning
  final VoidCallback onTapWarning;

  const NotificationFilterRow({
    super.key,
    required this.isAllSelected,
    required this.onTapAll,
    required this.onTapWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// زرار All
        NotificationFilterChip(
          title: 'All(6)',
          isSelected: isAllSelected,
          onTap: onTapAll,
        ),

        const SizedBox(width: 18),

        /// زرار Warning
        NotificationFilterChip(
          title: 'Warning(1)',
          isSelected: !isAllSelected,
          onTap: onTapWarning,
        ),
      ],
    );
  }
}