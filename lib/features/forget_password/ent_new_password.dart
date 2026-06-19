import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart' show RoutesManager;
import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_text_form_field.dart';
import 'package:smartkids_gurad/core/utils/app_snack_bar.dart';

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

    if (p1.isEmpty || p2.isEmpty) {
      showAppSnackBar(
        context,
        "Please enter password and return password",
      );
      return;
    }

    if (p1 != p2) {
      showAppSnackBar(
        context,
        "Passwords do not match",
      );
      return;
    }

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
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
                                    width: 307,
                                    height: 665,
                                    child: AuthCardContainer(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 18,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 18),

                                          // =========================
                                          // اللوجو
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
                                          const Center(
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
                                          CustomTextFormField(
                                            label: "Password",
                                            hint: "************",
                                            prefixAsset: ImageAssets.icPassword,
                                            prefixSize: 20,
                                            controller: passwordController,
                                            obscureText: obscurePassword,
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

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Return Password
                                          // =========================
                                          CustomTextFormField(
                                            label: "Return Password",
                                            hint: "************",
                                            prefixAsset: ImageAssets.icPassword,
                                            prefixSize: 20,
                                            controller: returnPasswordController,
                                            obscureText: obscureReturnPassword,
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

                                          const SizedBox(height: 70),

                                          // =========================
                                          // زر Change Password
                                          // =========================
                                          Center(
                                            child: CustomPrimaryButton(
                                              text: "Change Password",
                                              onPressed: _onChangePasswordPressed,
                                              fontSize: 18,
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
}