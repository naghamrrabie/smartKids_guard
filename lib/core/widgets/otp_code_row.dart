import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

class OtpCodeRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final double boxWidth;
  final double boxHeight;
  final double spacing;

  const OtpCodeRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
    this.boxWidth = 48,
    this.boxHeight = 44,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controllers.length, (i) {
        return Padding(
          padding: EdgeInsets.only(
            right: i == controllers.length - 1 ? 0 : spacing,
          ),
          child: SizedBox(
            width: boxWidth,
            height: boxHeight,
            child: TextField(
              controller: controllers[i],
              focusNode: focusNodes[i],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                counterText: "",
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.greyBorder,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.bluee,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (v) {
                if (v.isNotEmpty && i < controllers.length - 1) {
                  focusNodes[i + 1].requestFocus();
                }

                if (v.isEmpty && i > 0) {
                  focusNodes[i - 1].requestFocus();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}