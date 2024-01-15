import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class CustomTitleTextField extends StatelessWidget {
  const CustomTitleTextField({
    super.key,
    required this.fieldText,
    required this.hintText,
    this.controller,
    this.suffixWidget,
    this.onTFTap,
    this.obscureText = false,
    this.errorText,
    this.isReadyOnly = false,
    this.keyboardType,
  });
  final String fieldText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixWidget;
  final VoidCallback? onTFTap;
  final bool obscureText;
  final String? errorText;
  final bool isReadyOnly;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldText,
          style: const TextStyle(
            color: Color(0xFF181717),
            fontSize: 10,
            fontFamily: Assets.plusJakartaFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        gapH8,
        TextField(
          controller: controller,
          obscureText: obscureText,
          onTap: onTFTap,
          keyboardType: keyboardType,
          readOnly: isReadyOnly,
          style: StyleGuide.textStyle3.copyWith(color: const Color(0xFF2C2C2C)),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(124)),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(124)),
              borderSide: BorderSide(color: StyleGuide.primaryColor, width: 2),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(124)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(124)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            hintText: hintText,
            hintStyle: StyleGuide.textStyle3.copyWith(
              color: const Color(0xFF6B6B6B),
            ),
            errorText: errorText,
            errorStyle: StyleGuide.textStyle3.copyWith(color: Colors.red),
            suffixIcon: suffixWidget,
          ),
        ),
      ],
    );
  }
}
