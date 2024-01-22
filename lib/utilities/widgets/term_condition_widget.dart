import 'package:flutter/material.dart';

import '../constants/style_guide.dart';

class TermConditionWidget extends StatelessWidget {
  const TermConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "By signing up you agree to our ",
        children: [
          TextSpan(
              text: "Terms",
              style: StyleGuide.onboardingText1.copyWith(
                  fontWeight: FontWeight.w500, color: StyleGuide.primaryColor)),
          const TextSpan(text: " and "),
          TextSpan(
              text: "\nConditions of Use",
              style: StyleGuide.onboardingText1.copyWith(
                  fontWeight: FontWeight.w500, color: StyleGuide.primaryColor)),
        ],
      ),
      textAlign: TextAlign.center,
      style: StyleGuide.onboardingText1.copyWith(
          fontWeight: FontWeight.w500, color: const Color(0xFF9CA4AB)),
    );
  }
}
