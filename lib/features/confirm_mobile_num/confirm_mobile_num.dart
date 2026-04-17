import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ مهم جداً علشان digitsOnly
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart';

class ConfirmMobileNum extends StatefulWidget {
  const ConfirmMobileNum({super.key});

  @override
  State<ConfirmMobileNum> createState() => _ConfirmMobileNumState();
}

class _ConfirmMobileNumState extends State<ConfirmMobileNum> {
  // =========================
  // كنترولرز + فوكس للخانات الأربعة (OTP)
  // =========================
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // =========================
  // دالة بتجمع الأرقام كلها في String واحد
  // =========================
  String get _otp => _controllers.map((e) => e.text).join();

  @override
  void dispose() {
    // =========================
    // تنظيف الكنترولرز والفوكس علشان ميبقاش في memory leak
    // =========================
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // =========================
  // دالة بتتعامل مع زر Done
  // =========================
  void _onDonePressed() {
    // ✅ لو الكود أقل من 4 أرقام -> ميفتحش الصفحة اللي بعدها
    if (_otp.length < 4 || _controllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the 4-digit code"),
        ),
      );
      return;
    }

    // ✅ لو كله تمام -> روح لصفحة MobileNumConfirmed
    Navigator.pushNamed(context, RoutesManager.mobileNumConfirmed);
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
          // نفس ستايل الصفحات اللي قبلها (Responsive + يحافظ على مقاسات Figma)
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
                                // نفس عرض الكارد في الصفحات السابقة
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                MediaQuery.of(context).size.height * 0.83,

                                // =========================
                                // يحافظ على شكل الفيجما (تكبير/تصغير بدون تشويه)
                                // =========================
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    // مقاس الكارد الأصلي
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
                                        children: [
                                          const SizedBox(height: 18),

                                          // =========================
                                          // اللوجو الكبير (logo_messages.png)
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
                                          // عنوان الصفحة
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

                                          const SizedBox(height: 8),

                                          // =========================
                                          // وصف تحت العنوان
                                          // =========================
                                          Text(
                                            "Please Enter The 4 Digit Code Sent\nTo Your phone Number.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: ColorsManager.primary,
                                            ),
                                          ),

                                          const SizedBox(height: 28),

                                          // =========================
                                          // خانات OTP (4 خانات) - Underline
                                          // ✅ تقبل أرقام فقط + رقم واحد فقط
                                          // =========================
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: List.generate(4, (i) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: i == 3 ? 0 : 16),
                                                child: SizedBox(
                                                  width: 48,
                                                  height: 44,
                                                  child: TextField(
                                                    controller: _controllers[i],
                                                    focusNode: _focusNodes[i],

                                                    // ✅ كيبورد أرقام
                                                    keyboardType:
                                                    TextInputType.number,

                                                    // ✅ محاذاة النص في النص
                                                    textAlign: TextAlign.center,

                                                    // ✅ يمنع كتابة غير الأرقام + يمنع أكثر من رقم
                                                    // مهم: بدون const علشان كان عامل Error
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                    ],

                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                    ),

                                                    decoration:
                                                    const InputDecoration(
                                                      counterText: "",
                                                      isDense: true,
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: ColorsManager
                                                              .greyBorder,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: ColorsManager
                                                              .bluee,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),

                                                    onChanged: (v) {
                                                      // ✅ لو كتب رقم -> يروح للخانة اللي بعدها
                                                      if (v.isNotEmpty &&
                                                          i < 3) {
                                                        _focusNodes[i + 1]
                                                            .requestFocus();
                                                      }

                                                      // ✅ لو مسح -> يرجع للخانة اللي قبلها
                                                      if (v.isEmpty && i > 0) {
                                                        _focusNodes[i - 1]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),

                                          const SizedBox(height: 28),

                                          // =========================
                                          // زر Done
                                          // ✅ ميفتحش الصفحة إلا لو OTP = 4 أرقام
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
                                                  onPressed: _onDonePressed,
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
                                                    "Done",
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

                                          const SizedBox(height: 18),

                                          // =========================
                                          // صندوق المعلومة الرمادي تحت الزر
                                          // =========================
                                          Center(
                                            child: Container(
                                              width: 252,
                                              padding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorsManager
                                                    .greyBackground,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorsManager
                                                      .greyBorder,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.info_outline,
                                                    size: 16,
                                                    color:
                                                    ColorsManager.greyText,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      "If you don't receive an email within\n"
                                                          "a few minutes, please check your spam\n"
                                                          "folder or try again.",
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
                        // (مفيش سطر تحت الكارد في التصميم)
                        // =========================
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