import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/notification_setting_card.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/profile_header.dart';
import '../home/widgets/bottom_nav_bar.dart';
import 'widgets/profile_info_card.dart';
import 'widgets/child_profile_tile.dart';
import 'widgets/app_setting_tile.dart';
import 'widgets/logout_button.dart';

/// =======================================================
/// الشاشة الرئيسية الخاصة بالـ Profile
/// هنا بنجمع كل widgets الخاصة بالشاشة مع بعض
///
/// مهم:
/// شيلنا SafeArea من الـ body كله
/// لأن ProfileHeader نفسه بقى فيه SafeArea داخلي
/// وده بيحل مشكلة الفراغ اللي فوق الهيدر
/// =======================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون خلفية الشاشة
      backgroundColor: ColorsManager.lightBlue,

      /// ===================================================
      /// نفس الـ BottomNavBar اللي استخدمناه في الـ Home
      /// لكن currentIndex = 3 لأننا في صفحة Profile
      /// ===================================================
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (i) {
          /// لو ضغط على Home يرجع للهوم
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.homeScreen,
                  (route) => false,
            );

            /// لو ضغط على Profile وهو بالفعل فيها
          } else if (i == 3) {
            // مفيش حاجة تتعمل
          }
        },
      ),

      /// ===================================================
      /// هنا ما استخدمناش SafeArea على الشاشة كلها
      /// عشان الهيدر يبدأ من أول الشاشة بدون فراغ فوق
      /// ===================================================
      body: Column(
        children: [
          /// =================================================
          /// الهيدر بتاع صفحة البروفايل
          /// =================================================
          const ProfileHeader(),

          /// =================================================
          /// Expanded عشان الـ ListView ياخد باقي مساحة الشاشة
          /// =================================================
          Expanded(
            child: ListView(
              /// مسافات داخلية لمحتوى الصفحة
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              children: [
                /// ===========================================
                /// كارت بيانات المستخدم
                /// ===========================================
                const ProfileInfoCard(),
                const SizedBox(height: 22),

                /// ===========================================
                /// عنوان Children Profiles + Add Child
                /// ===========================================
                _SectionHeader(
                  title: 'Children Profiles',
                  actionText: 'Add Child',
                  onActionTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.studentRegistrationRoute,
                    );
                  },
                ),
                const SizedBox(height: 12),

                /// ===========================================
                /// كارت الطفل
                /// ===========================================
                const ChildProfileTile(),
                const SizedBox(height: 22),

                /// ===========================================
                /// عنوان Notifications
                /// ===========================================
                const _SectionOnlyTitle(title: 'Notifications'),
                const SizedBox(height: 12),

                /// ===========================================
                /// كارت إعدادات الإشعارات
                /// ===========================================
                const NotificationSettingsCard(),
                const SizedBox(height: 22),

                /// ===========================================
                /// عنوان App Setting
                /// ===========================================
                const _SectionOnlyTitle(title: 'App Setting'),
                const SizedBox(height: 12),

                /// ===========================================
                /// كارت اللغة
                /// ===========================================
                const AppSettingTile(),
                const SizedBox(height: 32),

                /// ===========================================
                /// زرار تسجيل الخروج
                /// ===========================================
                const LogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Widget صغير لعنوان قسم + action على اليمين
/// مثال:
/// Children Profiles      Add Child
/// =======================================================
class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;

  /// الدالة اللي بتشتغل لما المستخدم يضغط على Add Child
  final VoidCallback? onActionTap;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// عنوان القسم
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        /// Spacer بيدفع النص اللي على اليمين لآخر الصف
        const Spacer(),

        /// Add Child بقت button قابلة للضغط
        InkWell(
          onTap: onActionTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              actionText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorsManager.bluee,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// Widget صغير لعنوان قسم فقط بدون action
/// مثال:
/// Notifications
/// =======================================================
class _SectionOnlyTitle extends StatelessWidget {
  final String title;

  const _SectionOnlyTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}