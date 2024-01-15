import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class TextButtonChildWidget extends StatelessWidget {
  const TextButtonChildWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: Assets.plusJakartaFont,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: StyleGuide.primaryColor,
      ),
    );
  }
}
