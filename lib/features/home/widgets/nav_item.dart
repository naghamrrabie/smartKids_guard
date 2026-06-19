import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

/// Widget مسؤول عن عنصر واحد داخل الـ Bottom Navigation Bar
class NavItem extends StatelessWidget {
  /// النص اللي هيظهر تحت الأيقونة
  final String label;

  /// مسار الأيقونة من الـ assets
  final String asset;

  /// هل العنصر ده هو الحالي المختار ولا لأ
  /// لو true -> لونه هيبقى active
  /// لو false -> لونه هيبقى عادي
  final bool active;

  /// الدالة اللي بتتنفذ لما المستخدم يضغط على العنصر
  final VoidCallback onTap;

  /// Constructor لاستقبال كل البيانات المطلوبة للعنصر
  const NavItem({
    super.key,
    required this.label,
    required this.asset,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// تحديد لون العنصر حسب هو active ولا لأ
    /// لو متعلم -> أزرق
    /// لو مش متعلم -> رمادي
    final color = active ? ColorsManager.bluee : ColorsManager.greyText;

    return InkWell(
      /// الدالة اللي هتشتغل لما المستخدم يدوس على العنصر
      onTap: onTap,

      /// شكل الـ splash / touch feedback
      borderRadius: BorderRadius.circular(14),

      child: SizedBox(
        width: 90, // عرض كل عنصر في الـ bottom nav
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// الأيقونة
            Image.asset(
              asset,
              width: 40,
              height: 40,
              color: color, // تلوين الأيقونة حسب active
            ),

            /// مسافة بين الأيقونة والنص
            const SizedBox(height: 6),

            /// النص تحت الأيقونة
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                active ? FontWeight.w700 : FontWeight.w500, // لو active يبقى أتقل
                color: color, // نفس لون الأيقونة
              ),

              /// يمنع النص من الخروج برا المساحة لو كان طويل
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}