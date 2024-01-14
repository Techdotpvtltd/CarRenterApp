import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class OnboardingTextWidget extends StatelessWidget {
  const OnboardingTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: StyleGuide.textStyle1,
        ),
        gapH4,
        Text(
          subTitle,
          style: StyleGuide.textStyle2,
        ),
      ],
    );
  }
}
