import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/Notification/cubit/notification_cubit_states.dart';
import 'package:smartkids_gurad/features/Notification/data/models/notification_model.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';

// import 'notification_cubit.dart';
// import 'notification_model.dart';

import 'widgets/notification_header.dart';
import 'widgets/notification_alert_card_design.dart';
import 'widgets/notification_status_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  /// =====================================================
  /// المتغير ده بيحدد الفلتر الحالي (All, Critical, Warning, Info)
  /// أول ما الشاشة تفتح: All هي اللي بتكون مختارة
  /// =====================================================
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeScreen, (route) => false);
          } else if (i == 3) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.profileScreen, (route) => false);
          }
        },
      ),
      /// ===================================================
      /// حطينا الشاشة كلها جوه BlocBuilder عشان الهيدر يقرأ الأعداد
      /// ===================================================
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int allCount = 0;
          int criticalCount = 0;
          int warningCount = 0;
          int infoCount = 0;

          // لو الداتا جت، نحسب أعداد كل نوع
          if (state is NotificationSuccess) {
            allCount = state.notifications.length;
            criticalCount = state.notifications.where((n) => n.type == 'Critical').length;
            warningCount = state.notifications.where((n) => n.type == 'Warning').length;
            infoCount = state.notifications.where((n) => n.type == 'Info').length;
          }

          return Column(
            children: [
              /// =================================================
              /// الهيدر مبني بالبيانات الحقيقية
              /// =================================================
              NotificationHeader(
                selectedFilter: selectedFilter,
                allCount: allCount,
                criticalCount: criticalCount,
                warningCount: warningCount,
                infoCount: infoCount,
                onFilterChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),

              /// =================================================
              /// باقي محتوى الشاشة
              /// =================================================
              Expanded(
                child: _buildBodyContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  /// دالة لرسم المحتوى اللي تحت الهيدر بناءً على حالة الـ State
  Widget _buildBodyContent(NotificationState state) {
    if (state is NotificationLoading) {
      return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
    } else if (state is NotificationError) {
      return Center(
        child: Text(
          state.error,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    } else if (state is NotificationSuccess) {
      // 💡 الفلترة بناءً على الزرار اللي اليوزر داس عليه
      final displayList = selectedFilter == 'All'
          ? state.notifications
          : state.notifications.where((n) => n.type == selectedFilter).toList();

      if (displayList.isEmpty) {
        return const Center(
          child: Text(
            "No notifications to show.",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        itemCount: displayList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 18),
        itemBuilder: (context, index) {
          return _buildNotificationCard(displayList[index]);
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    if (notification.type == 'Info') {
      return NotificationStatusCard(
        iconAsset: ImageAssets.safeArrival,
        title: notification.title,
        subtitle: notification.details,
      );
    } else if (notification.type == 'Warning') {
      return NotificationAlertCard(
        iconAsset: ImageAssets.lowBattery,
        title: notification.title,
        subtitle: notification.details,
        cardColor: ColorsManager.lightYellow,
        borderColor: ColorsManager.darkYellow,
        dotColor: ColorsManager.darkYellow,
      );
    } else {
      // Critical
      return NotificationAlertCard(
        iconAsset: ImageAssets.warningTime,
        title: notification.title,
        subtitle: notification.details,
        showButton: true,
      );
    }
  }
}