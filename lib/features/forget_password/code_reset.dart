import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ digitsOnly
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart';

class CodeReset extends StatefulWidget {
  const CodeReset({super.key});

  @override
  State<CodeReset> createState() => _CodeResetState();
}

class _CodeResetState extends State<CodeReset> {
  // =========================
  // كنترولرز + فوكس للخانات الأربعة (OTP)
  // =========================
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // =========================
  // تجميع الكود كله
  // =========================
  String get _otp => _controllers.map((e) => e.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // =========================
  // زر Done: لازم 4 أرقام وبعدين يروح EnterNewPassword
  // =========================
  void _onDonePressed() {
    // ✅ لازم كل الخانات تتملأ (4 أرقام)
    if (_controllers.any((c) => c.text.isEmpty) || _otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the 4-digit code")),
      );
      return;
    }

    // ✅ لو كله تمام -> روحي لصفحة EnterNewPassword (روت موجود عندك)
    Navigator.pushNamed(context, RoutesManager.enterNewPassword);
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
                                height:
                                MediaQuery.of(context).size.height * 0.83,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
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
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 18),

                                          // =========================
                                          // اللوجو (logoMessages)
                                          // =========================
                                          SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: ClipOval(
                                              child: Image.asset(
                                                ImageAssets.logoMessages,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 22),

                                          // =========================
                                          // العنوان
                                          // =========================
                                          const Text(
                                            "Forget Password",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          // =========================
                                          // الوصف
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

                                          const SizedBox(height: 34),

                                          // =========================
                                          // OTP (4 خانات)
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
                                                    keyboardType:
                                                    TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                    ],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                    decoration:
                                                    const InputDecoration(
                                                      counterText: "",
                                                      isDense: true,
                                                      enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          ColorsManager.bluee,
                                                          width: 2,
                                                        ),
                                                      ),
                                                    ),
                                                    onChanged: (v) {
                                                      if (v.isNotEmpty &&
                                                          i < 3) {
                                                        _focusNodes[i + 1]
                                                            .requestFocus();
                                                      }
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

                                          const SizedBox(height: 46),

                                          // =========================
                                          // زر Done
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
                                                onPressed: _onDonePressed,
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

                                          const SizedBox(height: 20),

                                          // =========================
                                          // Info Box
                                          // =========================
                                          Container(
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
                                                  Icons.info_outline,
                                                  size: 16,
                                                  color: ColorsManager.greyText,
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    "If you don't receive an email within\n"
                                                        "a few minutes, please check your spam\n"
                                                        "folder or try again.",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color:
                                                      ColorsManager.greyText,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      height: 1.2,
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