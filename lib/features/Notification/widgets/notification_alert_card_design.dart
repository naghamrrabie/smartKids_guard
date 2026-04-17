import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'notification_action_button.dart';

/// =======================================================
/// Widget مسؤول عن كارت التحذير
/// زي:
/// - Unusual Location Detected
/// - Late Arrival Alert
/// - Low Battery Warning
/// - Bus Missed Alert
/// =======================================================
class NotificationAlertCard extends StatelessWidget {
  /// مسار الأيقونة من الـ assets
  final String iconAsset;

  /// عنوان الكارت
  final String title;

  /// النص التوضيحي تحت العنوان
  final String subtitle;

  /// هل الكارت فيه زرار View details ولا لا
  final bool showButton;

  /// لون خلفية الكارت
  final Color cardColor;

  /// لون البوردر
  final Color borderColor;

  /// لون النقطة اللي على اليمين
  final Color dotColor;

  const NotificationAlertCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.showButton = false,
    this.cardColor = const Color(0xFFFBECEF),
    this.borderColor = const Color(0xFFE9B8BE),
    this.dotColor = const Color(0xFFD93822),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافات داخلية للكارت
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),

        /// البوردر الخارجي
        border: Border.all(
          color: borderColor,
          width: 1.2,
        ),

        /// ظل خفيف تحت الكارت
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [
          /// الصف الأساسي: أيقونة + نصوص + النقطة
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// أيقونة الكارت
              Image.asset(
                iconAsset,
                width: 44,
                height: 44,
                fit: BoxFit.contain,
              ),

              const SizedBox(width: 14),

              /// النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// عنوان الكارت
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// النص التوضيحي
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F6F6F),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// النقطة اللي على اليمين
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),

          /// لو الكارت محتاج زرار View details نظهره
          if (showButton) ...[
            const SizedBox(height: 18),

            /// نخلي الزرار على اليمين
            const Align(
              alignment: Alignment.centerRight,
              child: NotificationActionButton(),
            ),
          ],
        ],
      ),
    );
  }
}