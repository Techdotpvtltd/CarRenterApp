import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
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
    this.isLoading = false,
    this.loadingText,
  });

  final double? width;
  final double? height;
  final String title;
  final Function() onPressed;
  final double? textSize;
  final bool withBorderOnly;
  final bool isLoading;
  final String? loadingText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
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
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
                gapW10,
                Text(
                  loadingText ?? "",
                  style: TextStyle(
                    fontFamily: Assets.plusJakartaFont,
                    fontWeight: FontWeight.w700,
                    fontSize: textSize ?? 16,
                    color: withBorderOnly
                        ? StyleGuide.primaryColor
                        : StyleGuide.textColor1,
                  ),
                )
              ],
            )
          : Text(
              title,
              style: TextStyle(
                fontFamily: Assets.plusJakartaFont,
                fontWeight: FontWeight.w700,
                fontSize: textSize ?? 16,
                color: withBorderOnly
                    ? StyleGuide.primaryColor
                    : StyleGuide.textColor1,
              ),
            ),
    );
  }
}
