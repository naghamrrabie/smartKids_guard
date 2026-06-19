import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String prefixAsset;
  final double prefixSize;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isError;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixAsset,
    required this.prefixSize,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isError = false,
    this.maxLength,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    OutlineInputBorder _errorBorderFrom(InputBorder? border) {
      if (border is OutlineInputBorder) {
        return border.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        );
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// عنوان الحقل
        Text(
          label,
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 6),

        /// الحقل نفسه
        Center(
          child: SizedBox(
            width: 252,
            height: 42,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              maxLength: maxLength,
              onChanged: onChanged,
              readOnly: readOnly,

              /// ده بيخفي العداد بتاع maxLength
              buildCounter: maxLength != null
                  ? (
                  context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) =>
              null
                  : null,

              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: suffix,

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

                enabledBorder:
                isError ? _errorBorderFrom(inputTheme.enabledBorder) : null,
                focusedBorder:
                isError ? _errorBorderFrom(inputTheme.focusedBorder) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}