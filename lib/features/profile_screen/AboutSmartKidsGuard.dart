import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'widgets/menu.dart';

/// =======================================================
/// شاشة About SmartKids Guard
/// الشاشة دي بتعرض:
/// - هيدر فوق
/// - عنوان الصفحة
/// - معلومات عن التطبيق
/// - الرؤية
/// - الرسالة
/// - القيم
/// - المميزات
///
/// ملاحظة مهمة:
/// ما استخدمناش SafeArea على الشاشة كلها
/// عشان الهيدر يطلع لأول الشاشة بدون الفراغ اللي فوق
/// =======================================================
class AboutSmartKidsGuard extends StatelessWidget {
  const AboutSmartKidsGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون الخلفية الأساسية للشاشة
      backgroundColor: ColorsManager.lightBlue,

      /// ===================================================
      /// هنا ما حطيناش SafeArea على الـ body كله
      /// عشان الهيدر يطلع لأول الشاشة
      /// ===================================================
      body: Column(
        children: [
          /// ===================================================
          /// الهيدر العلوي
          /// ===================================================
          const _AboutHeader(),

          /// ===================================================
          /// Expanded عشان الجزء اللي تحت الهيدر ياخد باقي مساحة الشاشة
          /// ===================================================
          Expanded(
            child: SingleChildScrollView(
              /// Padding خارجي لمحتوى الصفحة
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),

              /// كل النصوص جوه Column واحدة
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===============================
                  /// عنوان أول سيكشن
                  /// ===============================
                  Text(
                    'About SmartKids Guard',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  /// وصف عام للتطبيق
                  Text(
                    'Safe Me is a smart application designed to\n'
                        'keep every school trip safe and connected.\n'
                        'It allows parents and schools to track\n'
                        'the bus in real time and receive instant alerts\n'
                        'in case of any issues.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  /// ===============================
                  /// Our Vision
                  /// ===============================
                  Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  /// نص الرؤية
                  Text(
                    'To make every student’s journey to and from\n'
                        'school completely safe and worry-free.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  /// ===============================
                  /// Our Mission
                  /// ===============================
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  /// نص الرسالة
                  Text(
                    'To provide a smart and easy tool that\n'
                        'connects schools, drivers, and parents —\n'
                        'ensuring children’s safety at all times.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  /// ===============================
                  /// Core Values
                  /// ===============================
                  Text(
                    'Core Values',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  /// القيم الأساسية
                  Text(
                    '- Safety First\n'
                        '- Transparency and Trust\n'
                        '- Responsibility\n'
                        '- Innovation for a Better Experience',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  /// ===============================
                  /// Key Features
                  /// ===============================
                  Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  /// المميزات الأساسية للتطبيق
                  Text(
                    '- Live bus tracking.\n'
                        '- Instant alerts for delays or issues.\n'
                        '- Quick contact with school security or the driver.\n'
                        '- Simple and user-friendly interface.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
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
/// الهيدر الخاص بشاشة About
/// وظيفته يعرض:
/// - زرار الرجوع
/// - عنوان الصفحة
/// - زرار settings/menu
///
/// استخدمنا SafeArea جوه الهيدر نفسه فقط
/// عشان:
/// - الهيدر يطلع لأول الشاشة
/// - لكن المحتوى الداخلي ما يدخلش تحت الـ status bar
/// =======================================================
class _AboutHeader extends StatelessWidget {
  const _AboutHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر
      height: 120,

      /// عرض الهيدر بعرض الشاشة كله
      width: double.infinity,

      /// شكل الهيدر
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
      ),

      child: SafeArea(
        bottom: false,
        child: Padding(
          /// مسافة داخلية للمحتوى جوه الهيدر
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              /// =========================================
              /// زرار الرجوع
              /// =========================================
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28,
                ),
              ),

              const SizedBox(width: 4),

              /// =========================================
              /// عنوان الصفحة
              /// Expanded عشان ياخد المساحة المتبقية
              /// =========================================
              const Expanded(
                child: Text(
                  'About SmartKids Guard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              /// =========================================
              /// زرار المينيو
              /// لما المستخدم يضغط عليه يفتح MenuScreen كـ dialog
              /// =========================================
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