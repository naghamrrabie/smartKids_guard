import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/widgets/auth_card_container.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart';
import 'package:smartkids_gurad/core/widgets/info_note_box.dart';
import 'package:smartkids_gurad/core/widgets/otp_code_row.dart';
import 'package:smartkids_gurad/core/utils/app_snack_bar.dart';

class CodeReset extends StatefulWidget {
  const CodeReset({super.key});

  @override
  State<CodeReset> createState() => _CodeResetState();
}

class _CodeResetState extends State<CodeReset> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

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

  void _onDonePressed() {
    if (_controllers.any((c) => c.text.isEmpty) || _otp.length < 4) {
      showAppSnackBar(context, "Please enter the 4-digit code");
      return;
    }

    Navigator.pushNamed(context, RoutesManager.enterNewPassword);
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

                                          const SizedBox(height: 22),

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

                                          const Text(
                                            "Please Enter The 4 Digit Code Sent\nTo Your phone Number.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: ColorsManager.primary,
                                            ),
                                          ),

                                          const SizedBox(height: 34),

                                          OtpCodeRow(
                                            controllers: _controllers,
                                            focusNodes: _focusNodes,
                                          ),

                                          const SizedBox(height: 46),

                                          CustomPrimaryButton(
                                            text: "Done",
                                            onPressed: _onDonePressed,
                                          ),

                                          const SizedBox(height: 20),

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