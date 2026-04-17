import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../../core/resources/assets_manager.dart';

/// Widget مسؤول عن كارت بيانات الطفل
class ChildCard extends StatelessWidget {
  /// Constructor عادي لأن الكارت ثابت ومفيهوش بيانات متغيرة دلوقتي
  const ChildCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// مسافة داخلية بين حدود الكارت والمحتوى اللي جواه
      padding: const EdgeInsets.all(14),

      /// شكل الكارت الخارجي
      decoration: BoxDecoration(
        color: Colors.white, // لون خلفية الكارت
        borderRadius: BorderRadius.circular(16), // تقويس الحواف
        boxShadow: [
          // ظل للكارت عشان يبان منفصل عن الخلفية
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      /// محتوى الكارت متقسم صف أفقي:
      /// صورة الطفل على الشمال + البيانات على اليمين
      child: Row(
        children: [
          /// Stack هنا علشان نحط صورة الطفل
          /// وفوقها/عليها نقطة الـ online الخضرا
          Stack(
            children: [
              /// قص الصورة على شكل دائرة
              ClipOval(
                child: Image.asset(
                  ImageAssets.babyPhoto,
                  width: 78, // عرض الصورة
                  height: 78, // ارتفاع الصورة
                  fit: BoxFit.cover, // يملى المساحة بالكامل
                ),
              ),

              /// نقطة الـ online الخضرا في أسفل يمين الصورة
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DB954), // أخضر للحالة active
                    shape: BoxShape.circle, // شكل دائري
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ), // بوردر أبيض حول النقطة
                  ),
                ),
              ),
            ],
          ),

          /// مسافة بين الصورة والبيانات
          const SizedBox(width: 14),

          /// Expanded عشان النصوص تاخد باقي المساحة المتاحة
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// اسم الطفل
                Text(
                  'Eman Ahmed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 4),

                /// اسم المدرسة
                Text(
                  'Modern Future School',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),

                SizedBox(height: 3),

                /// رقم الطالب
                Text(
                  'Student ID: LES-2024-0892',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),

                SizedBox(height: 3),

                /// الصف الدراسي
                Text(
                  'Grade 5-A',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.greyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}