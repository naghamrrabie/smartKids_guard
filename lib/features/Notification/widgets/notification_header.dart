import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

import 'notification_filter_row..dart';

/// =======================================================
/// Widget مسؤول عن الهيدر العلوي في شاشة Notification
/// فيه:
/// - زرار back
/// - عنوان الصفحة
/// - أيقونة التنبيهات مع البادج
/// - صف الفلاتر All / Warning
/// =======================================================
class NotificationHeader extends StatelessWidget {
  /// هل All هي المختارة؟
  final bool isAllSelected;

  /// دالة الضغط على All
  final VoidCallback onTapAll;

  /// دالة الضغط على Warning
  final VoidCallback onTapWarning;

  const NotificationHeader({
    super.key,
    required this.isAllSelected,
    required this.onTapAll,
    required this.onTapWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر
      height: MediaQuery.of(context).padding.top + 160,
      width: double.infinity,

      /// شكل الهيدر
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
      ),

      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// الصف الأول: back + title + icon + badge
              Row(
                children: [
                  /// زرار الرجوع
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 4),

                  /// عنوان الشاشة
                  const Expanded(
                    child: Text(
                      'Notification&Alerts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  /// أيقونة التنبيهات + البادج
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 28,
                      ),
                      Positioned(
                        right: -10,
                        top: -8,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD93822),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '4',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 22),

              /// صف الفلاتر جوه الهيدر نفسه
              NotificationFilterRow(
                isAllSelected: isAllSelected,
                onTapAll: onTapAll,
                onTapWarning: onTapWarning,
              ),
            ],
          ),
        ),
      ),
    );
  }
}