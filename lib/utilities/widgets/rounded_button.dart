import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';

import '../constants/style_guide.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
  });

  final double? width;
  final double? height;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(
          Size(
            width ?? double.infinity,
            height ?? 60,
          ),
        ),
        backgroundColor:
            const MaterialStatePropertyAll(StyleGuide.primaryColor),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: Assets.plusJakartaFont,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: StyleGuide.textColor1,
        ),
      ),
    );
  }
}
