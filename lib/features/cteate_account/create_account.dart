import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart' show RoutesManager;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  /// للتحكم في إظهار/إخفاء الباسورد
  bool obscurePassword = true;

  /// للتحكم في إظهار/إخفاء تأكيد الباسورد
  bool obscureConfirmPassword = true;

  /// للتحكم في 체크 بوكس الموافقة
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // خلفية الشاشة (تدرج)
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
          // LayoutBuilder + Scroll علشان تدعم الشاشات الصغيرة
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
                        // جزء الكارد (أكبر/أصغر تلقائي)
                        // =========================
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              // مسافة بسيطة من فوق (Responsive)
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                              ),

                              // =========================
                              // مساحة الكارد Responsive
                              // =========================
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                MediaQuery.of(context).size.height * 0.83,

                                // =========================
                                // BoxFit.contain => يحافظ على شكل الفيجما
                                // =========================
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    // =========================
                                    // مقاس الكارد الأصلي في Figma
                                    // =========================
                                    width: 307,
                                    height: 665,
                                    child: Container(
                                      // بادينج داخلي للكارد
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 18,
                                      ),

                                      // شكل الكارد (زوايا + ظل)
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.08),
                                            blurRadius: 30,
                                            offset: const Offset(0, 14),
                                          ),
                                        ],
                                      ),

                                      // =========================
                                      // محتوى الكارد
                                      // =========================
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // =========================
                                          // شريط علوي داخل الكارد (Back + Create Account)
                                          // =========================
                                          Row(
                                            children: [
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints:
                                                const BoxConstraints(),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text(
                                                "Create Account",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // اللوجو (الدائرة كلها صورة)
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 70,
                                              height: 70,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  ImageAssets.SplashLogo,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // عنوان Join...
                                          // =========================
                                          Center(
                                            child: Text(
                                              "Join Smartkids Gurad Community",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.bluee,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Full Name
                                          // =========================
                                          const Text(
                                            "Full Name",
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
                                                decoration: _fieldDecoration(
                                                  hint: "Your Name",
                                                  prefixAsset:
                                                  ImageAssets.icName,
                                                  prefixSize: 20,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

                                          // =========================
                                          // Phone Number
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
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                keyboardType:
                                                TextInputType.phone,
                                                decoration: _fieldDecoration(
                                                  hint: "01060621021",
                                                  prefixAsset:
                                                  ImageAssets.icPhone,
                                                  prefixSize: 24,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

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
                                                obscureText: obscurePassword,
                                                decoration: _fieldDecoration(
                                                  hint: "**********",
                                                  prefixAsset:
                                                  ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscurePassword =
                                                        !obscurePassword;
                                                      });
                                                    },
                                                    icon: Image.asset(
                                                      ImageAssets.icEye,
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.contain,
                                                      color:
                                                      ColorsManager.greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

                                          // =========================
                                          // Confirm Password
                                          // =========================
                                          const Text(
                                            "Confirm Password",
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
                                                obscureText:
                                                obscureConfirmPassword,
                                                decoration: _fieldDecoration(
                                                  hint: "**********",
                                                  prefixAsset:
                                                  ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureConfirmPassword =
                                                        !obscureConfirmPassword;
                                                      });
                                                    },
                                                    icon: Image.asset(
                                                      ImageAssets.icEye,
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.contain,
                                                      color:
                                                      ColorsManager.greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 22),

                                          // =========================
                                          // Checkbox: الموافقة على الشروط
                                          // =========================
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: Checkbox(
                                                  value: agree,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      agree = v ?? false;
                                                    });
                                                  },
                                                  activeColor:
                                                  ColorsManager.bluee,
                                                  side: const BorderSide(
                                                    color:
                                                    ColorsManager.greyBorder,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(3),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Expanded(
                                                child: Text(
                                                  "I agree to the Terms of Service and\nPrivacy Policy",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: ColorsManager.greyText,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 26),

                                          // =========================
                                          // زر Next Step (بنفس Gradient بتاع ColorsManager.blue)
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient: ColorsManager.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, RoutesManager.confirmMobileNum);
                                                  },
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    shadowColor:
                                                    Colors.transparent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Next Step",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w700,
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

                        // =========================
                        // ✅ السطر اللي تحت الكارد (مكانه مظبوط زي الصورة)
                        // =========================
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsManager.greyText,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // يرجع لصفحة اللوجين
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesManager.login,
                                        (route) => false,
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsManager.bluee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
  // ديكور موحد للحقول (نفس بتاع Login)
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

      // النص التلميحي داخل الحقل
      hintText: hint,
      hintStyle: const TextStyle(
        color: ColorsManager.greyText,
        fontSize: 12,
      ),

      // أيقونة قبل النص (من assets)
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8),
        child: Image.asset(
          prefixAsset,
          width: prefixSize,
          height: prefixSize,
          fit: BoxFit.contain,
          color: ColorsManager.greyText, // شيليها لو الأيقونة ملونة
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 42,
      ),

      // أيقونة بعد النص (العين)
      suffixIcon: suffix,

      // بادينج النص داخل الحقل
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      // شكل الحقل في الوضع العادي
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.greyBorder,
          width: 1,
        ),
      ),

      // شكل الحقل عند الضغط
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