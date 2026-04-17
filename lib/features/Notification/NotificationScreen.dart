import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';
import 'widgets/notification_header.dart';
import 'widgets/notification_alert_card_design.dart';
import 'widgets/notification_status_card.dart';

/// =======================================================
/// شاشة NotificationScreen
/// دي الشاشة الأساسية اللي بتجمع:
/// - الهيدر
/// - الفلاتر All / Warning (جوه الهيدر)
/// - كروت الإشعارات
/// - Bottom Navigation Bar
///
/// الشاشة Stateful لأن محتوى الكروت بيتغير
/// حسب الزرار المختار:
/// - All
/// - Warning
/// =======================================================
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  /// =====================================================
  /// المتغير ده بيحدد الفلتر الحالي
  /// true  = All
  /// false = Warning
  ///
  /// أول ما الشاشة تفتح:
  /// All هي اللي بتكون مختارة
  /// =====================================================
  bool isAllSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون خلفية الشاشة كلها
      backgroundColor: ColorsManager.lightBlue,

      /// ===================================================
      /// نفس الـ BottomNavBar القديمة
      /// currentIndex = 2 لأننا في شاشة Notification
      /// ===================================================
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (i) {
          /// لو المستخدم ضغط على Home
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.homeScreen,
                  (route) => false,
            );

            /// لو المستخدم ضغط على Profile
          } else if (i == 3) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.profileScreen,
                  (route) => false,
            );
          }
        },
      ),

      /// ===================================================
      /// هنا ما استخدمناش SafeArea على الشاشة كلها
      /// عشان الهيدر يطلع لأول الشاشة
      /// ===================================================
      body: Column(
        children: [
          /// =================================================
          /// الهيدر
          /// =================================================
          NotificationHeader(
            isAllSelected: isAllSelected,
            onTapAll: () {
              setState(() {
                isAllSelected = true;
              });
            },
            onTapWarning: () {
              setState(() {
                isAllSelected = false;
              });
            },
          ),

          /// =================================================
          /// باقي محتوى الشاشة
          /// =================================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =================================================
                  /// لو All مختارة
                  /// =================================================
                  if (isAllSelected) ...[
                    /// Unusual Location Detected
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.warningLocation,
                      title: 'Unusual Location Detected',
                      subtitle: 'Child detected outside of safe zone',
                      cardColor: ColorsManager.lightYellow,
                      borderColor: ColorsManager.darkYellow,
                      dotColor: ColorsManager.darkYellow,
                    ),
                    const SizedBox(height: 18),

                    /// Late Arrival Alert
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.warningTime,
                      title: 'Late Arrival Alert',
                      subtitle: 'Child has not arrived at school yet',
                      showButton: true,
                    ),
                    const SizedBox(height: 18),

                    /// Safe Arrival
                    const NotificationStatusCard(
                      iconAsset: ImageAssets.safeArrival,
                      title: 'Safe Arrival',
                      subtitle: 'Your child has arrived safely at school',
                    ),
                    const SizedBox(height: 18),

                    /// Low Battery Warning
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.lowBattery,
                      title: 'Low Battery Warning',
                      subtitle: 'RFID device battery is running\nlow (15%)',
                      cardColor: ColorsManager.lightYellow,
                      borderColor: ColorsManager.darkYellow,
                      dotColor: ColorsManager.darkYellow,
                    ),
                    const SizedBox(height: 18),

                    /// Safe Departure
                    const NotificationStatusCard(
                      iconAsset: ImageAssets.safeArrival,
                      title: 'Safe Departure',
                      subtitle: 'Your child has left school premises',
                    ),
                    const SizedBox(height: 18),

                    /// Bus Missed Alert
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.missBus,
                      title: 'Bus Missed Alert',
                      subtitle: 'Child did not get on the bus',
                      showButton: true,
                    ),
                  ],

                  /// =================================================
                  /// لو Warning مختارة
                  /// هنا شيلنا:
                  /// - Unusual Location Detected
                  /// - Low Battery Warning
                  /// وخَلّيناهم في All فقط
                  /// =================================================
                  if (!isAllSelected) ...[
                    /// Late Arrival Alert
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.warningTime,
                      title: 'Late Arrival Alert',
                      subtitle: 'Child has not arrived at school yet',
                      showButton: true,
                    ),
                    const SizedBox(height: 18),

                    /// Bus Missed Alert
                    const NotificationAlertCard(
                      iconAsset: ImageAssets.missBus,
                      title: 'Bus Missed Alert',
                      subtitle: 'Child did not get on the bus',
                      showButton: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}