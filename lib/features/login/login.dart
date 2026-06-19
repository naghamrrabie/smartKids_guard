import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart' show RoutesManager;
import 'package:smartkids_gurad/core/widgets/custom_outlined_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_text_form_field.dart';
import 'package:smartkids_gurad/features/login/cubit/login_cubit.dart';
import 'package:smartkids_gurad/features/login/cubit/login_state.dart';

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
      /// تم التعديل لـ 11 رقم عشان أرقام مصر
      phoneError = phoneController.text.trim().length != 11;

      /// لازم الباسورد مايبقاش فاضي
      passwordError = passwordController.text.trim().isEmpty;
    });

    /// لو مفيش أخطاء نعمل Navigate
    if (!phoneError && !passwordError) {
      // نادي على الـ Cubit عشان يضرب الـ API
      context.read<LoginCubit>().login(
        phoneController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // BlocConsumer علشان نسمع للـ Cubit
      // =========================
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // لو نجح، نقفل شاشة اللوجين ونروح للرئيسية
            Navigator.pushReplacementNamed(context, RoutesManager.homeScreen);
          } else if (state is LoginError) {
            // لو في مشكلة نعرض رسالة الخطأ
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
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
                                    height: MediaQuery.of(context).size.height * 0.83,
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
                                                color: Colors.black.withOpacity(0.08),
                                                blurRadius: 30,
                                                offset: const Offset(0, 14),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                              // Login to Smartkids Guard
                                              // =========================
                                              const Center(
                                                child: Text(
                                                  "Login to Smartkids Guard", // صلحت الكلمة لـ Guard بدل Gurad
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorsManager.bluee,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 18),

                                              // =========================
                                              // Phone Number
                                              // =========================
                                              CustomTextFormField(
                                                label: "Phone Number",
                                                hint: "01060621021",
                                                prefixAsset: ImageAssets.icPhone,
                                                prefixSize: 24,
                                                controller: phoneController,
                                                keyboardType: TextInputType.phone,
                                                maxLength: 11, // متناسقة مع أرقام مصر
                                                isError: phoneError,
                                                onChanged: (value) {
                                                  if (phoneError) {
                                                    setState(() {
                                                      phoneError = value.trim().length != 11;
                                                    });
                                                  }
                                                },
                                              ),

                                              const SizedBox(height: 14),

                                              // =========================
                                              // Password
                                              // =========================
                                              CustomTextFormField(
                                                label: "Password",
                                                hint: "**********",
                                                prefixAsset: ImageAssets.icPassword,
                                                prefixSize: 20,
                                                controller: passwordController,
                                                obscureText: obscurePassword,
                                                isError: passwordError,
                                                onChanged: (value) {
                                                  if (passwordError) {
                                                    setState(() {
                                                      passwordError = value.trim().isEmpty;
                                                    });
                                                  }
                                                },
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

                                              const SizedBox(height: 10),

                                              // =========================
                                              // Remember me + Forget Password
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
                                                      activeColor: ColorsManager.bluee,
                                                      side: const BorderSide(
                                                        color: ColorsManager.greyBorder,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(3),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    "Remember me",
                                                    style: TextStyle(fontSize: 11),
                                                  ),
                                                  const Spacer(),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        RoutesManager.resetPassword,
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      minimumSize: const Size(0, 0),
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    ),
                                                    child: const Text(
                                                      "Forget Password?",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: ColorsManager.bluee,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 33),

                                              // =========================
                                              // زر Login أو علامة التحميل
                                              // =========================
                                              Center(
                                                child: state is LoginLoading
                                                    ? const CircularProgressIndicator(color: ColorsManager.bluee)
                                                    : CustomPrimaryButton(
                                                  text: "Login",
                                                  onPressed: _validateAndLogin,
                                                  fontSize: 17,
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
                                                      color: ColorsManager.greyBorder,
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: Text("Or", style: TextStyle(fontSize: 15)),
                                                  ),
                                                  Expanded(
                                                    child: Divider(
                                                      color: ColorsManager.greyBorder,
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
                                                child: CustomOutlinedButton(
                                                  text: "Create New Account",
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      RoutesManager.createAccountRoute,
                                                    );
                                                  },
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
          );
        },
      ),
    );
  }
}