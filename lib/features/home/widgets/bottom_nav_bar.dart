import 'package:flutter/material.dart';
import 'nav_item.dart';
import '../../../core/resources/assets_manager.dart';

/// =======================================================
/// Widget مسؤول عن شريط التنقل السفلي (Bottom Navigation Bar)
/// وظيفته:
/// - يعرض 4 عناصر تحت
/// - يحدد العنصر الحالي النشط
/// - يبعت رقم العنصر اللي المستخدم ضغط عليه للشاشة
/// =======================================================
class BottomNavBar extends StatelessWidget {
  /// رقم التاب الحالي المختار
  final int currentIndex;

  /// دالة بتتنفذ لما المستخدم يضغط على أي عنصر
  /// الشاشة اللي بتستخدم BottomNavBar هي اللي بتحدد هتعمل إيه
  final ValueChanged<int> onTap;

  /// Constructor لاستقبال الـ currentIndex والـ onTap
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع البوتوم بار
      height: 96,

      /// مسافة داخلية من فوق وتحت
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),

      /// شكل البوتوم بار
      decoration: BoxDecoration(
        color: Colors.white,

        /// تقويس الحواف العلوية فقط
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),

        /// ظل خفيف للفصل بين البار ومحتوى الشاشة
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),

      child: Row(
        /// توزيع العناصر بالتساوي
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// =================================================
          /// Home
          /// =================================================
          NavItem(
            label: 'Home',
            asset: ImageAssets.icHome,
            active: currentIndex == 0,
            onTap: () => onTap(0),
          ),

          /// =================================================
          /// Location
          /// =================================================
          NavItem(
            label: 'Location',
            asset: ImageAssets.icLocation,
            active: currentIndex == 1,
            onTap: () => onTap(1),
          ),

          /// =================================================
          /// Notification
          /// لما المستخدم يضغط عليه بيرجع index = 2
          /// والشاشة نفسها هي اللي تعمل navigation
          /// =================================================
          NavItem(
            label: 'Notification',
            asset: ImageAssets.icNotification,
            active: currentIndex == 2,
            onTap: () => onTap(2),
          ),

          /// =================================================
          /// Profile
          /// =================================================
          NavItem(
            label: 'Profile',
            asset: ImageAssets.icProfile,
            active: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}