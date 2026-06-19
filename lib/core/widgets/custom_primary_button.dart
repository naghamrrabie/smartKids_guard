import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 17, // القيمة الافتراضية زي ما طلبت
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       // عشان الزرار ياخد العرض كله، ممكن تشيلها لو عايزه على قد الكلمة
      height: 55, // ارتفاع الزرار، تقدر تعدله زي ما تحب
      decoration: BoxDecoration(
        // التدرج اللوني (Gradient) من الشمال لليمين
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8DB4FF), // درجة الأزرق الفاتح اللي على الشمال
            Color(0xFF3E7BFA), // درجة الأزرق الغامق اللي على اليمين
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        // حواف دائرية بنفس درجة الزاوية في الصورة
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // نخلي الزرار شفاف عشان التدرج يظهر
          shadowColor: Colors.transparent, // نشيل الضل عشان ميبوظش شكل الألوان
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // لازم نفس الـ radius بتاع الـ Container
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold, // خط عريض زي الصورة
          ),
        ),
      ),
    );
  }
}