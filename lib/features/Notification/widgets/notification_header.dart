import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/features/Notification/widgets/notification_filter_row..dart';

class NotificationHeader extends StatelessWidget {
  final String selectedFilter;
  final int allCount;
  final int criticalCount;
  final int warningCount;
  final int infoCount;
  final ValueChanged<String> onFilterChanged;

  const NotificationHeader({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.criticalCount,
    required this.warningCount,
    required this.infoCount,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + 160,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Notification&Alerts',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.black, size: 28),
                      Positioned(
                        right: -10,
                        top: -8,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(color: Color(0xFFD93822), shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              // عدد الإشعارات الجديدة ممكن نربطه بالـ Critical مثلاً أو برقم ثابت حالياً
                              allCount > 0 ? allCount.toString() : '0',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),

              /// باصينا الأعداد للـ Row
              NotificationFilterRow(
                selectedFilter: selectedFilter,
                allCount: allCount,
                criticalCount: criticalCount,
                warningCount: warningCount,
                infoCount: infoCount,
                onFilterChanged: onFilterChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}