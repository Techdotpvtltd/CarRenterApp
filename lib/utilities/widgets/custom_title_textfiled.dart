import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class CustomTitleTextFiled extends StatelessWidget {
  const CustomTitleTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email Address",
          style: TextStyle(
            color: Color(0xFF181717),
            fontSize: 10,
            fontFamily: Assets.plusJakartaFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        gapH8,
        TextField(
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
            hintText: "Hi",
            errorStyle: StyleGuide.textStyle3.copyWith(color: Colors.red),
            hintStyle: StyleGuide.textStyle3.copyWith(
              color: const Color(0xFF6B6B6B),
            ),
          ),
        ),
      ],
    );
  }
}
