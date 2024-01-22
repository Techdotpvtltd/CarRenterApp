import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class TextButtonChildWidget extends StatelessWidget {
  const TextButtonChildWidget(
      {super.key, required this.text, this.textColor, this.fontWeight});
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: Assets.plusJakartaFont,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: textColor ?? StyleGuide.primaryColor,
      ),
    );
  }
}

class TextButtonChildWidget2 extends StatelessWidget {
  const TextButtonChildWidget2({super.key, required this.text, this.textColor});
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: Assets.plusJakartaFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor ?? StyleGuide.primaryColor,
      ),
    );
  }
}
