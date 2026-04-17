import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart' show RoutesManager;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// للتحكم في إظهار/إخفاء الباسورد
  bool obscurePassword = true;

  /// للتحكم في قيمة CheckBox
  bool rememberMe = false;

  /// Controllers لقراءة القيم من الحقول
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// متغيرات لإظهار البوردر الأحمر عند الخطأ
  bool phoneError = false;
  bool passwordError = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// دالة التحقق قبل الـ Login
  void _validateAndLogin() {
    setState(() {
      /// لازم رقم الموبايل يكون 12 رقم بالظبط
      phoneError = phoneController.text.trim().length != 12;

      /// لازم الباسورد مايبقاش فاضي
      passwordError = passwordController.text.trim().isEmpty;
    });

    /// لو مفيش أخطاء نعمل Navigate
    if (!phoneError && !passwordError) {
      Navigator.pushNamed(context, RoutesManager.homeScreen);
    }
  }

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
          // LayoutBuilder + Scroll علشان تمنع overflow
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
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                MediaQuery.of(context).size.height * 0.83,

                                // =========================
                                // الحفاظ على مقاسات الفيجما
                                // =========================
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: 307,
                                    height: 665,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 22,
                                      ),
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

                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // =========================
                                          // اللوجو
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
                                          // Welcome Back
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Welcome Back",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          // =========================
                                          // Login to Smartkids Gurad
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Login to Smartkids Gurad",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.bluee,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // عنوان Phone Number
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
                                          // حقل Phone Number
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller: phoneController,
                                                keyboardType:
                                                TextInputType.phone,

                                                /// يمنع كتابة أكثر من 12 رقم
                                                maxLength: 12,

                                                /// يخفي عداد maxLength تحت الحقل
                                                buildCounter: (
                                                    context, {
                                                      required currentLength,
                                                      required isFocused,
                                                      maxLength,
                                                    }) =>
                                                null,

                                                onChanged: (value) {
                                                  /// أول ما المستخدم يبدأ يكتب بشكل صحيح نشيل الأحمر
                                                  if (phoneError) {
                                                    setState(() {
                                                      phoneError =
                                                          value.trim().length !=
                                                              12;
                                                    });
                                                  }
                                                },

                                                decoration: _fieldDecoration(
                                                  hint: "01060621021",
                                                  prefixAsset:
                                                  ImageAssets.icPhone,
                                                  prefixSize: 24,
                                                  suffix: null,
                                                  isError: phoneError,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

                                          // =========================
                                          // عنوان Password
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

                                          // =========================
                                          // حقل Password
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller: passwordController,
                                                obscureText: obscurePassword,
                                                onChanged: (value) {
                                                  if (passwordError) {
                                                    setState(() {
                                                      passwordError = value
                                                          .trim()
                                                          .isEmpty;
                                                    });
                                                  }
                                                },
                                                decoration: _fieldDecoration(
                                                  hint: "**********",
                                                  prefixAsset:
                                                  ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  isError: passwordError,
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
                                                      color: ColorsManager
                                                          .greyText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // Remember me + Forget Password
                                          // الاتنين في سطر واحد
                                          // =========================
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: Checkbox(
                                                  value: rememberMe,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      rememberMe = v ?? false;
                                                    });
                                                  },
                                                  activeColor:
                                                  ColorsManager.bluee,
                                                  side: const BorderSide(
                                                    color: ColorsManager
                                                        .greyBorder,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(3),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                "Remember me",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const Spacer(),

                                              /// هنا شيلنا الـ Flexible وخففنا padding الزرار
                                              /// علشان النص يفضل في سطر واحد
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    RoutesManager.resetPassword,
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize:
                                                  const Size(0, 0),
                                                  tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                                ),
                                                child: const Text(
                                                  "Forget Password?",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                    ColorsManager.bluee,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 33),

                                          // =========================
                                          // زر Login
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient:
                                                  ColorsManager.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: _validateAndLogin,
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    shadowColor:
                                                    Colors.transparent,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Login",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 40),

                                          // =========================
                                          // فاصل Or
                                          // =========================
                                          Row(
                                            children: const [
                                              Expanded(
                                                child: Divider(
                                                  color: ColorsManager
                                                      .greyBorder,
                                                  thickness: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  "Or",
                                                  style:
                                                  TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: ColorsManager
                                                      .greyBorder,
                                                  thickness: 1,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 33),

                                          // =========================
                                          // زر Create New Account
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    RoutesManager
                                                        .createAccountRoute,
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                  const Color(0xFFFAFAFA),
                                                  side: const BorderSide(
                                                    color: ColorsManager
                                                        .greyBorder,
                                                    width: 1,
                                                  ),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Create New Account",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: Colors.black,
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
                        // نص الشروط تحت الكارد
                        // =========================
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            "By continuing, you agree to our Terms\nof Service and Privacy Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: ColorsManager.greyText,
                            ),
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
  // ديكور الحقول بدون تغيير الـ UI
  // =========================
  InputDecoration _fieldDecoration({
    required String hint,
    required String prefixAsset,
    required double prefixSize,
    required Widget? suffix,
    required bool isError,
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

      // أيقونة قبل النص
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

      // أيقونة بعد النص
      suffixIcon: suffix,

      // بادينج النص داخل الحقل
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      // البوردر العادي
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isError ? Colors.red : ColorsManager.greyBorder,
          width: 1,
        ),
      ),

      // البوردر عند الضغط
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isError ? Colors.red : ColorsManager.bluee,
          width: 1,
        ),
      ),
    );
  }
}