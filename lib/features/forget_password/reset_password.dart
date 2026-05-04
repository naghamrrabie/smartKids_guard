import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';

import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/custom_text_form_field.dart';
import 'package:smartkids_gurad/core/widgets/info_note_box.dart';
import 'package:smartkids_gurad/core/utils/app_snack_bar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _onSend() {
    if (phoneController.text.trim().isEmpty) {
      showAppSnackBar(context, "Please enter phone number");
      return;
    }

    Navigator.pushNamed(context, RoutesManager.codeReset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 18),

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

                                          const SizedBox(height: 16),

                                          const Text(
                                            "Enter Number",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          const Text(
                                            "Enter your Number to reset\nyour password.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),

                                          const SizedBox(height: 38),

                                          CustomTextFormField(
                                            label: "Phone Number",
                                            hint: "Phone Number",
                                            prefixAsset: ImageAssets.icPhone,
                                            prefixSize: 22,
                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                          ),

                                          const SizedBox(height: 34),

                                          CustomPrimaryButton(
                                            text: "Send reset link",
                                            onPressed: _onSend,
                                            fontSize: 14,
                                          ),

                                          const SizedBox(height: 12),

                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(
                                                    Icons.arrow_back_ios_new,
                                                    size: 14,
                                                    color: ColorsManager.bluee,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    "Back to login",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorsManager.bluee,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 26),

                                          const InfoNoteBox(
                                            text:
                                            "If you don't receive an email within\n"
                                                "a few minutes, please check your spam\n"
                                                "folder or try again.",
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
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