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
    this.withBorderOnly = false,
  });

  final double? width;
  final double? height;
  final String title;
  final Function() onPressed;
  final double? textSize;
  final bool withBorderOnly;
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
        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        side: MaterialStatePropertyAll(BorderSide(
            color:
                withBorderOnly ? StyleGuide.primaryColor : Colors.transparent)),
        backgroundColor: MaterialStatePropertyAll(
            withBorderOnly ? Colors.transparent : StyleGuide.primaryColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: Assets.plusJakartaFont,
          fontWeight: FontWeight.w700,
          fontSize: textSize ?? 16,
          color:
              withBorderOnly ? StyleGuide.primaryColor : StyleGuide.textColor1,
        ),
      ),
    );
  }
}
