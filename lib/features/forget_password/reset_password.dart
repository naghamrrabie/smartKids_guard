import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import '../../core/resources/assets_manager.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // كنترولر لحقل رقم الموبايل
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // خلفية الشاشة (Gradient)
      // =========================
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsManager.lightBlue, Colors.white],
          ),
        ),

        child: SafeArea(
          // =========================
          // نفس Responsive system المستخدم في كل الشاشات
          // =========================
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // =========================
                        // الكارد الأساسي
                        // =========================
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              // مسافة بسيطة من فوق
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                              ),

                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height: MediaQuery.of(context).size.height * 0.83,

                                // يحافظ على مقاسات الفيجما
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: 307,
                                    height: 665,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.08),
                                            blurRadius: 30,
                                            offset: const Offset(0, 14),
                                          ),
                                        ],
                                      ),

                                      // =========================
                                      // محتوى الكارد
                                      // =========================
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 18),

                                          // =========================
                                          // اللوجو الكبير (logoMessages)
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  ImageAssets.logoMessages,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 16),

                                          // =========================
                                          // العنوان: Enter Number
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Enter Number",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          // =========================
                                          // الوصف
                                          // =========================
                                          Center(
                                            child: Text(
                                              "Enter your Number to reset\nyour password.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 38),

                                          // =========================
                                          // Label: Phone Number
                                          // =========================
                                          const Text(
                                            "Phone Number",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          // =========================
                                          // TextField: Phone Number
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller: phoneController,
                                                keyboardType: TextInputType.phone,
                                                decoration: _fieldDecoration(
                                                  hint: "Phone Number",
                                                  prefixAsset: ImageAssets.icPhone, // ✅ icPhone
                                                  prefixSize: 22,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 34),

                                          // =========================
                                          // زر Send reset link
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient: ColorsManager.blue,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      // ✅ لو رقم الموبايل فاضي
                                                      if (phoneController.text.trim().isEmpty) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(
                                                            content: Text("Please enter phone number"),
                                                          ),
                                                        );
                                                        return;
                                                      }

                                                      // ✅ لو فيه رقم -> يفتح صفحة CodeReset
                                                      Navigator.pushNamed(context, RoutesManager.codeReset);

                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Send reset link",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          // =========================
                                          // Back to login (سهم + نص)
                                          // =========================
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                // يرجع لصفحة اللوجين
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(
                                                    Icons.arrow_back_ios_new,
                                                    size: 14,
                                                    color: ColorsManager.bluee,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    "Back to login",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorsManager.bluee,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 26),

                                          // =========================
                                          // Info Box تحت (زي اللي في UI)
                                          // =========================
                                          Center(
                                            child: Container(
                                              width: 252,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorsManager.greyBackground,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorsManager.greyBorder,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.info_outline,
                                                    size: 16,
                                                    color: ColorsManager.greyText,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      "If you don't receive an email within\n"
                                                          "a few minutes, please check your spam\n"
                                                          "folder or try again.",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: ColorsManager.greyText,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================
  // ديكور موحد للحقول (نفس اللي عندك)
  // =========================
  static InputDecoration _fieldDecoration({
    required String hint,
    required String prefixAsset,
    required double prefixSize,
    required Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.white,

      hintText: hint,
      hintStyle: const TextStyle(
        color: ColorsManager.greyText,
        fontSize: 12,
      ),

      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8),
        child: Image.asset(
          prefixAsset,
          width: prefixSize,
          height: prefixSize,
          fit: BoxFit.contain,
          color: ColorsManager.greyText,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 42,
      ),

      suffixIcon: suffix,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.greyBorder,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.bluee,
          width: 1,
        ),
      ),
    );
  }
}