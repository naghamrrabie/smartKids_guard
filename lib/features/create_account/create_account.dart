import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
import 'package:smartkids_gurad/core/widgets/bottom_action_text.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_text_form_field.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  /// التحكم في إظهار/إخفاء الباسورد
  bool obscurePassword = true;

  /// التحكم في إظهار/إخفاء تأكيد الباسورد
  bool obscureConfirmPassword = true;

  /// controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  /// متغيرات الخطأ
  bool fullNameError = false;
  bool phoneError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndContinue() {
    setState(() {
      fullNameError = fullNameController.text.trim().isEmpty;
      phoneError = phoneController.text.trim().length != 12;
      passwordError = passwordController.text.trim().isEmpty;
      confirmPasswordError =
          confirmPasswordController.text.trim().isEmpty ||
              confirmPasswordController.text.trim() !=
                  passwordController.text.trim();
    });

    if (!fullNameError &&
        !phoneError &&
        !passwordError &&
        !confirmPasswordError) {
      Navigator.pushNamed(context, RoutesManager.confirmMobileNum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // خلفية الشاشة
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
                                height:
                                MediaQuery.of(context).size.height * 0.83,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: 307,
                                    height: 665,
                                    child: AuthCardContainer(
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
                                          // العنوان
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Create Account",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Center(
                                            child: Text(
                                              "Create your Smartkids Gurad account",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.bluee,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Full Name
                                          // =========================
                                          CustomTextFormField(
                                            label: "Full Name",
                                            hint: "Enter Full Name",
                                            prefixAsset: ImageAssets.icName,
                                            prefixSize: 20,
                                            controller: fullNameController,
                                            isError: fullNameError,
                                            onChanged: (value) {
                                              if (fullNameError) {
                                                setState(() {
                                                  fullNameError =
                                                      value.trim().isEmpty;
                                                });
                                              }
                                            },
                                          ),

                                          const SizedBox(height: 14),

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
                                            maxLength: 12,
                                            isError: phoneError,
                                            onChanged: (value) {
                                              if (phoneError) {
                                                setState(() {
                                                  phoneError =
                                                      value.trim().length != 12;
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
                                            prefixAsset:
                                            ImageAssets.icPassword,
                                            prefixSize: 20,
                                            controller: passwordController,
                                            obscureText: obscurePassword,
                                            isError: passwordError,
                                            onChanged: (value) {
                                              if (passwordError) {
                                                setState(() {
                                                  passwordError =
                                                      value.trim().isEmpty;
                                                });
                                              }
                                            },
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

                                          const SizedBox(height: 14),

                                          // =========================
                                          // Confirm Password
                                          // =========================
                                          CustomTextFormField(
                                            label: "Confirm Password",
                                            hint: "**********",
                                            prefixAsset:
                                            ImageAssets.icPassword,
                                            prefixSize: 20,
                                            controller:
                                            confirmPasswordController,
                                            obscureText:
                                            obscureConfirmPassword,
                                            isError: confirmPasswordError,
                                            onChanged: (value) {
                                              if (confirmPasswordError) {
                                                setState(() {
                                                  confirmPasswordError =
                                                      value.trim().isEmpty ||
                                                          value.trim() !=
                                                              passwordController
                                                                  .text
                                                                  .trim();
                                                });
                                              }
                                            },
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

                                          const SizedBox(height: 36),

                                          // =========================
                                          // زر Next Step
                                          // =========================
                                          Center(
                                            child: CustomPrimaryButton(
                                              text: "Next Step",
                                              onPressed: _validateAndContinue,
                                            ),
                                          ),

                                          const Spacer(),
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
                        // السطر اللي تحت الكارد
                        // =========================
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: BottomActionText(
                            normalText: "Already have an account? ",
                            actionText: "Login",
                            onTap: () {
                              Navigator.pop(context);
                            },
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
}