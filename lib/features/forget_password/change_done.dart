import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';

class ChangeDone extends StatelessWidget {
  const ChangeDone({super.key});

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
          // نفس نظام الـ Responsive اللي عندك
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
                                    width: 307,
                                    height: 665,

                                    // =========================
                                    // هنا استخدمنا AuthCardContainer
                                    // بدل الـ Container الأبيض المتكرر
                                    // =========================
                                    child: AuthCardContainer(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 40),

                                          // =========================
                                          // اللوجو (Group + icTrue فوق بعض)
                                          // =========================
                                          SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  ImageAssets.group,
                                                  width: 110,
                                                  height: 110,
                                                  fit: BoxFit.contain,
                                                ),
                                                Image.asset(
                                                  ImageAssets.icTrue,
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.contain,
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(height: 24),

                                          // =========================
                                          // العنوان
                                          // =========================
                                          const Text(
                                            "Confirm mobile phone",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // الوصف
                                          // =========================
                                          const Text(
                                            "The mobile number has been\nconfirmed to be active.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: ColorsManager.primary,
                                              height: 1.3,
                                            ),
                                          ),

                                          const Spacer(),

                                          // =========================
                                          // زر Done
                                          // =========================
                                          CustomPrimaryButton(
                                            text: "Done",
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                RoutesManager.homeScreen,
                                                    (route) => false,
                                              );
                                            },
                                          ),

                                          const SizedBox(height: 160),
                                        ],
                                      ),
                                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}