import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'widgets/menu.dart';

/// =======================================================
/// شاشة Help & Support
/// الشاشة دي بتعرض:
/// - Header فوق
/// - أسئلة شائعة
/// - كروت التواصل مع الدعم
/// - كارت Quick Tips
///
/// ملاحظة مهمة:
/// ما استخدمناش SafeArea على الشاشة كلها
/// عشان الهيدر يطلع لأول الشاشة بدون الفراغ اللي فوق
/// =======================================================
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون خلفية الشاشة كلها
      backgroundColor: ColorsManager.lightBlue,

      /// ===================================================
      /// هنا ما حطيناش SafeArea على الـ body كله
      /// عشان الهيدر نفسه يبقى لازق في أول الشاشة
      /// والمشكلة اللي كانت ظاهرة فوق تتحل
      /// ===================================================
      body: Column(
        children: [
          /// ===================================================
          /// Header
          /// ===================================================
          const _HelpSupportHeader(),

          /// ===================================================
          /// Expanded عشان المحتوى ياخد باقي مساحة الشاشة
          /// ===================================================
          Expanded(
            child: SingleChildScrollView(
              /// مسافة داخلية لمحتوى الشاشة
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===================================================
                  /// FAQ Items
                  /// ===================================================
                  const _QuestionTile(
                    title: 'How Can I add my child to the app?',
                  ),
                  const SizedBox(height: 14),

                  const _QuestionTile(
                    title: 'How do I enable or disable\nnotifications?',
                  ),
                  const SizedBox(height: 14),

                  const _QuestionTile(
                    title: 'What should I do if I forget my\npassword?',
                  ),
                  const SizedBox(height: 22),

                  /// ===================================================
                  /// عنوان Contact Support
                  /// ===================================================
                  const Text(
                    'Contacts Support',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),

                  /// ===================================================
                  /// Email Support Card
                  /// ===================================================
                  const _SupportCard(
                    bgColor: Color(0xFFA6E6B6),
                    borderColor: Color(0xFF2ED06E),
                    shadowColor: Color(0x332ED06E),
                    iconAsset: ImageAssets.emailSupport,
                    title: 'Email Support',
                    subtitle1: 'support@safeme.app',
                    subtitle2: "We'll respond within 24 hours",
                  ),
                  const SizedBox(height: 18),

                  /// ===================================================
                  /// Phone Support Card
                  /// ===================================================
                  const _SupportCard(
                    bgColor: Color(0xFFD8B6F5),
                    borderColor: Color(0xFFB065E8),
                    shadowColor: Color(0x33B065E8),
                    iconAsset: ImageAssets.phoneSupport,
                    title: 'Phone Support',
                    subtitle1: 'support@safeme.app',
                    subtitle2: "We'll respond within 24 hours",
                  ),
                  const SizedBox(height: 22),

                  /// ===================================================
                  /// Quick Tips Card
                  /// ===================================================
                  const _QuickTipsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Header الخاص بشاشة Help & Support
///
/// هنا استخدمنا SafeArea جوه الهيدر نفسه فقط
/// عشان:
/// - الهيدر يطلع لأول الشاشة
/// - لكن الأيقونات والنص ما يدخلوش في الـ status bar
/// =======================================================
class _HelpSupportHeader extends StatelessWidget {
  const _HelpSupportHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر
      height: 115,

      /// ياخد عرض الشاشة كله
      width: double.infinity,

      /// الشكل الخارجي للهيدر
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),

      /// ===================================================
      /// SafeArea هنا فقط
      /// bottom: false معناها نحمي من فوق فقط
      /// لكن من تحت لا
      /// ===================================================
      child: SafeArea(
        bottom: false,
        child: Padding(
          /// مسافة داخلية للمحتوى جوه الهيدر
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              /// زرار الرجوع
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
              ),

              const SizedBox(width: 4),

              /// عنوان الصفحة
              const Expanded(
                child: Text(
                  'Help&Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              /// زرار المينيو
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (_) => const MenuScreen(),
                  );
                },
                icon: Image.asset(
                  ImageAssets.rivetIconsSettings,
                  width: 26,
                  height: 26,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// Widget مسؤول عن سؤال واحد من الأسئلة الشائعة
/// =======================================================
class _QuestionTile extends StatelessWidget {
  final String title;

  const _QuestionTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: const Color(0xFFDDEAF4),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          /// أيقونة السؤال
          const Icon(
            Icons.help_outline,
            color: ColorsManager.bluee,
            size: 30,
          ),

          const SizedBox(width: 10),

          /// نص السؤال
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),

          /// السهم اللي على اليمين
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 28,
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Widget مسؤول عن كارت دعم واحد
/// مثال:
/// - Email Support
/// - Phone Support
/// =======================================================
class _SupportCard extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final Color shadowColor;
  final String iconAsset;
  final String title;
  final String subtitle1;
  final String subtitle2;

  const _SupportCard({
    required this.bgColor,
    required this.borderColor,
    required this.shadowColor,
    required this.iconAsset,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية
      padding: const EdgeInsets.all(18),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الصف الأول: أيقونة + عنوان
          Row(
            children: [
              Image.asset(
                iconAsset,
                width: 38,
                height: 38,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// السطر الأول من البيانات
          Text(
            subtitle1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),

          /// السطر الثاني من البيانات
          Text(
            subtitle2,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Widget مسؤول عن كارت Quick Tips
/// =======================================================
class _QuickTipsCard extends StatelessWidget {
  const _QuickTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية
      padding: const EdgeInsets.all(18),

      /// شكل الكارت
      decoration: BoxDecoration(
        color: const Color(0xFFD2D8D5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFA9AEAB),
          width: 1.2,
        ),
      ),

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// عنوان الكارت
          Row(
            children: [
              Text(
                '💡',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 8),
              Text(
                'Quick Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          /// النصائح
          Text(
            '• Keep your app updated for the\n'
                'latest features\n'
                '• Test the SOS button with your\n'
                'child monthly\n'
                '• Review and update emergency\n'
                'contacts regularly\n'
                '• Enable location services for\n'
                'accurate tracking',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}