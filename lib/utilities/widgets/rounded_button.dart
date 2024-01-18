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
    this.textSize,
  });

  final double? width;
  final double? height;
  final String title;
  final Function() onPressed;
  final double? textSize;

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
        style: TextStyle(
          fontFamily: Assets.plusJakartaFont,
          fontWeight: FontWeight.w700,
          fontSize: textSize ?? 16,
          color: StyleGuide.textColor1,
        ),
      ),
    );
  }
}
