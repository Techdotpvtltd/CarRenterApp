import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class OnBoardingCenteredWidget extends StatelessWidget {
  const OnBoardingCenteredWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.centeredWidget,
    this.bottomWidget,
  });
  final String iconPath;
  final String title;
  final String subtitle;
  final Widget? centeredWidget;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapSreenHeight(0.03),
        Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Color(0xFFF6F8FE),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            iconPath,
            height: 85,
            width: 85,
            fit: BoxFit.contain,
          ),
        ),
        gapSreenHeight(0.05),
        Text(
          title,
          style: const TextStyle(
            color: StyleGuide.textColor2,
            fontFamily: Assets.poppinsFont,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        gapH8,
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF868686),
            fontWeight: FontWeight.w400,
            fontSize: 10,
            fontFamily: Assets.plusJakartaFont,
          ),
        ),
        Visibility(
          visible: centeredWidget != null,
          child: gapSreenHeight(0.08),
        ),
        if (centeredWidget != null) centeredWidget!,
        gapSreenHeight(0.08),
        if (bottomWidget != null) bottomWidget!,
      ],
    );
  }
}
