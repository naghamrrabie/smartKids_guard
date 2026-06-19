import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

class InfoNoteBox extends StatelessWidget {
  final String text;
  final double width;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
  final double iconSize;

  const InfoNoteBox({
    super.key,
    required this.text,
    this.width = 252,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.borderRadius = 10,
    this.fontSize = 11,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: ColorsManager.greyBackground,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: ColorsManager.greyBorder,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: iconSize,
              color: ColorsManager.greyText,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: ColorsManager.greyText,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}