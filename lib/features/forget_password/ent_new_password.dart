import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart' show RoutesManager;

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({super.key});

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {
  /// كنترولرز علشان نقدر نتحقق من الباسوردين
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController returnPasswordController = TextEditingController();

  /// لإظهار/إخفاء الباسورد
  bool obscurePassword = true;
  bool obscureReturnPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    returnPasswordController.dispose();
    super.dispose();
  }

  // =========================
  // زر Change Password
  // =========================
  void _onChangePasswordPressed() {
    final p1 = passwordController.text.trim();
    final p2 = returnPasswordController.text.trim();

    // ✅ تحقق بسيط
    if (p1.isEmpty || p2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter password and return password")),
      );
      return;
    }

    if (p1 != p2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    // TODO: هنا بعدين هتعملي API لتغيير الباسورد
    // مؤقتًا: رجّعيه للوجين أو أي صفحة تحبي
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesManager.changeDone,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // خلفية الشاشة (تدرّج)
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
          // Responsive + يحافظ على مقاسات Figma
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
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height: MediaQuery.of(context).size.height * 0.83,

                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    // مقاس الكارد الثابت بتاعكم
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
                                          // اللوجو (logoMessages)
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

                                          const SizedBox(height: 18),

                                          // =========================
                                          // العنوان
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Forget Password",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          // =========================
                                          // الوصف
                                          // =========================
                                          Center(
                                            child: Text(
                                              "Please Enter New Password.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.primary,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 40),

                                          // =========================
                                          // Password
                                          // =========================
                                          const Text(
                                            "Password",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller: passwordController,
                                                obscureText: obscurePassword,
                                                decoration: _fieldDecoration(
                                                  hint: "************",
                                                  prefixAsset: ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscurePassword = !obscurePassword;
                                                      });
                                                    },
                                                    icon: Image.asset(
                                                      ImageAssets.icEye,
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.contain,
                                                      color: ColorsManager.greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Return Password
                                          // =========================
                                          const Text(
                                            "Return Password",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller: returnPasswordController,
                                                obscureText: obscureReturnPassword,
                                                decoration: _fieldDecoration(
                                                  hint: "************",
                                                  prefixAsset: ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureReturnPassword =
                                                        !obscureReturnPassword;
                                                      });
                                                    },
                                                    icon: Image.asset(
                                                      ImageAssets.icEye,
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.contain,
                                                      color: ColorsManager.greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 70),

                                          // =========================
                                          // زر Change Password
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
                                                  onPressed: _onChangePasswordPressed,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Change Password",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
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
  // ديكور موحد للحقول (نفس بتاع باقي الشاشات)
  // =========================
  InputDecoration _fieldDecoration({
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