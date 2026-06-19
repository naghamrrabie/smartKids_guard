import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
// import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_text_form_field.dart';
import 'package:smartkids_gurad/core/widgets/info_note_box.dart';

class StudentDevice extends StatefulWidget {
  const StudentDevice({super.key});

  @override
  State<StudentDevice> createState() => _StudentDeviceState();
}

class _StudentDeviceState extends State<StudentDevice> {
  /// للتحكم في إظهار/إخفاء Security Key
  bool obscureKey = true;

  /// Controllers
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController securityKeyController = TextEditingController();

  @override
  void dispose() {
    studentIdController.dispose();
    securityKeyController.dispose();
    super.dispose();
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
                                          // الوصف
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
                                          CustomTextFormField(
                                            label: "Student Id",
                                            hint: "Enter Student Id",
                                            prefixAsset: ImageAssets.icId,
                                            prefixSize: 18,
                                            controller: studentIdController,
                                          ),

                                          const SizedBox(height: 18),

                                          // =========================
                                          // Security Key
                                          // =========================
                                          CustomTextFormField(
                                            label: "Security Key",
                                            hint: "************",
                                            prefixAsset: ImageAssets.icPassword,
                                            prefixSize: 20,
                                            controller: securityKeyController,
                                            obscureText: obscureKey,
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
                                                color: ColorsManager.greyText,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 50),
                                          // =========================
                                          // Info Box
                                          // =========================
                                          const InfoNoteBox(
                                            text:
                                            "This information will be linked to your\n"
                                                "child's RFID tag for tracking and safety\n"
                                                "monitoring.",
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                          ),

                                          const SizedBox(height: 56),

                                          // =========================
                                          // زر Connect Device
                                          // =========================
                                          ///*****************************************************************************************************************
                                          Center(
                                            // child: CustomPrimaryButton(
                                            //   text: "Connect Device",
                                            //   onPressed: () {
                                            //     Navigator.pushNamedAndRemoveUntil(
                                            //       context,
                                            //       RoutesManager.homeScreen,
                                            //           (route) => false,
                                            //     );
                                            //   },
                                            // ),
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