import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 238,
    this.height = 44,
    this.borderRadius = 12,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}