import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import '../../core/resources/assets_manager.dart';

class StudentDevice extends StatefulWidget {
  const StudentDevice({super.key});

  @override
  State<StudentDevice> createState() => _StudentDeviceState();
}

class _StudentDeviceState extends State<StudentDevice> {
  /// للتحكم في إظهار/إخفاء Security Key (زي الباسورد)
  bool obscureKey = true;

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
                        // جزء الكارد (Responsive)
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
                                // يحافظ على مقاسات وشكل Figma
                                // =========================
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    // =========================
                                    // مقاس الكارد الأصلي (زي باقي الشاشات)
                                    // =========================
                                    width: 307,
                                    height: 665,
                                    child: Container(
                                      // =========================
                                      // بادينج داخلي للكارد
                                      // =========================
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 18,
                                      ),

                                      // =========================
                                      // شكل الكارد (زوايا + ظل)
                                      // =========================
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
                                          const SizedBox(height: 30),

                                          // =========================
                                          // عنوان الصفحة
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Pair Student Device",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          // =========================
                                          // الوصف اللي تحت العنوان (بالأزرق)
                                          // =========================
                                          Center(
                                            child: Text(
                                              "Enter the student ID and Device\nsecurity key to link the tracking device",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.bluee,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 55),

                                          // =========================
                                          // Student Id
                                          // =========================
                                          const Text(
                                            "Student Id",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          // حقل Student Id
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                decoration: _fieldDecoration(
                                                  hint: "Enter Student Id",
                                                  prefixAsset: ImageAssets.icId,
                                                  prefixSize: 18,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Security Key
                                          // =========================
                                          const Text(
                                            "Security Key",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          // حقل Security Key (أيقونة نفس الباسورد + عين)
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                obscureText: obscureKey,
                                                decoration: _fieldDecoration(
                                                  hint: "************",
                                                  prefixAsset:
                                                  ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        obscureKey = !obscureKey;
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

                                          // ✅ المسافة هنا بقت أكبر قبل الـ Info Box
                                          const SizedBox(height: 50),

                                          // =========================
                                          // ✅ Info Box في Container (كارد صغير)
                                          // =========================
                                          Center(
                                            child: Container(
                                              width: 252,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                ColorsManager.greyBackground,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorsManager.greyBorder,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.lightbulb_outline,
                                                    size: 16,
                                                    color:
                                                    ColorsManager.greyText,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      "This information will be linked to your\n"
                                                          "child's RFID tag for tracking and safety\n"
                                                          "monitoring.",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: ColorsManager
                                                            .greyText,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // ✅ المسافة هنا بقت أكبر بين الـ Info Box والزر
                                          const SizedBox(height: 56),

                                          // =========================
                                          // ✅ زر Connect Device داخل Container (Gradient)
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: ColorsManager.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      RoutesManager.homeScreen,
                                                          (route) => false,
                                                    );
                                                  },
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
                                                    "Connect Device",
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
  // ديكور موحد للحقول (نفس ستايل Login/CreateAccount)
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

      // النص التلميحي
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
          color: ColorsManager.greyText,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 42,
      ),

      // أيقونة بعد النص
      suffixIcon: suffix,

      // بادينج النص
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      // شكل الحقل عادي
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.greyBorder,
          width: 1,
        ),
      ),

      // شكل الحقل عند التركيز
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