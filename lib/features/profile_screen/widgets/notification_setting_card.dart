import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

/// Widget مسؤول عن كارت إعدادات الإشعارات
/// هنا خليناه StatefulWidget لأن فيه Switches حالتها بتتغير
class NotificationSettingsCard extends StatefulWidget {
  const NotificationSettingsCard({super.key});

  @override
  State<NotificationSettingsCard> createState() =>
      _NotificationSettingsCardState();
}

class _NotificationSettingsCardState extends State<NotificationSettingsCard> {
  /// حالة السويتش الأول: Push Notifications
  bool pushNotificationsEnabled = true;

  /// حالة السويتش الثاني: Daily Summary Reports
  bool dailyReportsEnabled = true;

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

      child: Column(
        children: [
          /// أول سطر Notification
          _NotificationRow(
            iconAsset: ImageAssets.pushNotification,
            title: 'Push Notifications',
            subtitle: 'Recieve alerts on your device',
            value: pushNotificationsEnabled,

            /// لما المستخدم يغير السويتش
            /// بنحدث القيمة ونعمل rebuild
            onChanged: (value) {
              setState(() {
                pushNotificationsEnabled = value;
              });
            },
          ),

          /// خط فاصل بين الصفين
          const Divider(height: 24, thickness: 1),

          /// ثاني سطر Notification
          _NotificationRow(
            iconAsset: ImageAssets.pushDaily,
            title: 'Push Notifications',
            subtitle: 'Daily summary reports',
            value: dailyReportsEnabled,

            /// تحديث حالة السويتش الثاني
            onChanged: (value) {
              setState(() {
                dailyReportsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

/// Widget داخلي مسؤول عن صف واحد داخل كارت الإشعارات
class _NotificationRow extends StatelessWidget {
  /// مسار الأيقونة من الـ assets
  final String iconAsset;

  /// عنوان السطر
  final String title;

  /// الوصف الصغير تحت العنوان
  final String subtitle;

  /// القيمة الحالية للسويتش
  final bool value;

  /// الدالة اللي بتتنده لما السويتش يتغير
  final ValueChanged<bool> onChanged;

  const _NotificationRow({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      /// الأيقونة من الـ assets
      Image.asset(
      iconAsset,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    ),

    const SizedBox(width: 14),

    /// النصوص
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    /// عنوان السطر
    Text(
    title,
    style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    ),
    ),

    const SizedBox(height: 4),

    /// وصف السطر
    Text(
    subtitle,
    style: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColorsManager.greyText,
    ),
    ),
    ],
    ),
    ),

    /// السويتش
    Switch(
    value: value,
    onChanged: onChanged,
    activeColor: Colors.white,
      activeTrackColor: Colors.black,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.black,
    ),
      ],
    );
  }
}