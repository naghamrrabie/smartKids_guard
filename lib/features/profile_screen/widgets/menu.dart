import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

/// Widget مسؤول عن الـ popup menu اللي بيظهر فوق صفحة البروفايل
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      /// لو المستخدم ضغط برا المينيو -> تقفل
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            /// مكان المينيو فوق يمين
            Positioned(
              top: 70,
              right: 15,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      /// أول زرار
                      MenuTile(
                        title: 'Privacy&Setting',
                        trailingIcon: Icons.shield_outlined,
                        routeName: RoutesManager.helpSupportScreen,
                      ),

                      /// تاني زرار
                      MenuTile(
                        title: 'Help&Support',
                        trailingIcon: Icons.help_outline,
                        routeName: RoutesManager.helpSupportScreen,
                      ),

                      /// تالت زرار
                      MenuTile(
                        title: 'About SmartKids Guard',
                        trailingIcon: Icons.info_outline,
                        routeName: RoutesManager.aboutSmartKidsGuard,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget مسؤول عن عنصر واحد داخل المينيو
class MenuTile extends StatelessWidget {
  /// اسم العنصر
  final String title;

  /// الأيقونة اللي على اليمين
  final IconData trailingIcon;

  /// اسم الراوت اللي هيفتحه العنصر
  final String routeName;

  const MenuTile({
    super.key,
    required this.title,
    required this.trailingIcon,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /// نقفل الـ menu الأول
        Navigator.pop(context);

        /// بعد قفلها نفتح الصفحة المطلوبة
        Future.microtask(() {
          Navigator.pushNamed(context, routeName);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            /// السهم اللي على الشمال
            const Icon(
              Icons.chevron_left,
              color: Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 10),

            /// عنوان العنصر
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            /// الأيقونة اللي على اليمين
            Icon(
              trailingIcon,
              color: Colors.black,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}