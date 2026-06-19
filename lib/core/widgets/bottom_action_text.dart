import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

class BottomActionText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;
  final double normalFontSize;
  final double actionFontSize;

  const BottomActionText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.normalFontSize = 16,
    this.actionFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: TextStyle(
            fontSize: normalFontSize,
            color: ColorsManager.greyText,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: actionFontSize,
              color: ColorsManager.bluee,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}