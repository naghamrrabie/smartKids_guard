import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart' show RoutesManager;

class MobileNumConfirmed extends StatelessWidget {
  const MobileNumConfirmed({super.key});

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
          // نفس نظام الـ Responsive اللي عندك (علشان يطابق الفيجما)
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
                        // الكارد الأساسي (يكبر/يصغر تلقائي)
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
                                height:
                                MediaQuery.of(context).size.height * 0.83,

                                // =========================
                                // يحافظ على مقاسات الفيجما بدون تشويه
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
                                        vertical: 22,
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
                                                // الخلفية (Group)
                                                Image.asset(
                                                  ImageAssets.group,
                                                  width: 110,
                                                  height: 110,
                                                  fit: BoxFit.contain,
                                                ),

                                                // العلامة الصح (icTrue)
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
                                          // العنوان: Confirm mobile phone
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
                                          // الوصف اللي تحت العنوان
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
                                          // زر Done (بنفس Gradient بتاع ColorsManager.blue)
                                          // =========================
                                          SizedBox(
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
                                                  // =========================
                                                  // هنا هتحددي هنروح فين بعد التأكيد
                                                  // مثال (لو عايزة ترجعي Login):
                                                  // Navigator.pushNamedAndRemoveUntil(
                                                  //   context,
                                                  //   RoutesManager.login,
                                                  //   (route) => false,
                                                  // );
                                                  // =========================

                                                  // TODO: غيّري الوجهة حسب الـ Flow عندك
                                                  Navigator.pushNamed(
                                                    context,
                                                    RoutesManager.studentRegistrationRoute,
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
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
                                                  "Done",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
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

                        // =========================
                        // مفيش نص تحت الكارد في التصميم ده
                        // =========================
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