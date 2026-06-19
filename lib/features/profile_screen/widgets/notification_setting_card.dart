import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';

class NotificationSettingsCard extends StatelessWidget {
  final ProfileResponseModel profile; // الداتا اللي جاية من الشاشة اللي بره

  const NotificationSettingsCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          _NotificationRow(
            iconAsset: ImageAssets.pushNotification,
            title: 'Push Notifications',
            subtitle: 'Recieve alerts on your device',
            // 💡 الزرار بيقرا حالته من السيرفر (من الـ profile model)
            value: profile.isNotificationsEnabled,
            onChanged: (value) {
              // 💡 لما تدوس، بيكلم الـ Cubit عشان يشوف شغله
              context.read<ProfileCubit>().togglePushNotifications(value);
            },
          ),
          const Divider(height: 24, thickness: 1),
          _NotificationRow(
            iconAsset: ImageAssets.pushDaily,
            title: 'Daily Summary',
            subtitle: 'Daily summary reports',
            value: profile.isReportsEnabled,
            onChanged: (value) {
              // ممكن تعمل دالة تانية للـ Reports لو ليها API خاص بيها
            },
          ),
        ],
      ),
    );
  }
}

// الـ Widget الداخلي زي ما هو متغيرش فيه حاجة
class _NotificationRow extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String subtitle;
  final bool value;
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
        Image.asset(iconAsset, width: 40, height: 40, fit: BoxFit.contain),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorsManager.greyText)),
            ],
          ),
        ),
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