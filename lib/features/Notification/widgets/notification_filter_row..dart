import 'package:flutter/material.dart';
import 'notification_filter_chip.dart';

class NotificationFilterRow extends StatelessWidget {
  final String selectedFilter;
  final int allCount;
  final int criticalCount;
  final int warningCount;
  final int infoCount;
  final ValueChanged<String> onFilterChanged;

  const NotificationFilterRow({
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          NotificationFilterChip(
            title: 'All($allCount)',
            isSelected: selectedFilter == 'All',
            onTap: () => onFilterChanged('All'),
          ),
          const SizedBox(width: 12),
          NotificationFilterChip(
            title: 'Critical($criticalCount)',
            isSelected: selectedFilter == 'Critical',
            onTap: () => onFilterChanged('Critical'),
          ),
          const SizedBox(width: 12),
          NotificationFilterChip(
            title: 'Warning($warningCount)',
            isSelected: selectedFilter == 'Warning',
            onTap: () => onFilterChanged('Warning'),
          ),
          const SizedBox(width: 12),
          NotificationFilterChip(
            title: 'Info($infoCount)',
            isSelected: selectedFilter == 'Info',
            onTap: () => onFilterChanged('Info'),
          ),
        ],
      ),
    );
  }
}