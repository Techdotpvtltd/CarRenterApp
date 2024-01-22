import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';

class StyleGuide {
  // Colors  ========================================
  /// Use For BoundedButtons, Navigation Background, pop_up/dialogs,
  ///
  /// 3474FF
  static const Color primaryColor = Color(0xFF3474FF);

  /// Use For Widget's background,
  ///
  /// 3563E8
  static const Color primaryColor2 = Color(0xFF3563E8);

  /// Use For Screen Background,
  static const Color backgroundColor = Colors.white;

  /// User For Card Background, Value: F5F6FB
  static const Color backgroundColor2 = Color(0xFFF5F6FB);

  /// User For Button Title, Black or other background's widget
  static const Color textColor1 = Colors.white;

  /// User For Onboarding Title, Value: 1E1E1E
  static const Color textColor2 = Color(0xFF1E1E1E);

  // Text Style ======================================

  /// User for Onboarding title and on BackgroundWidget Title
  static const TextStyle textStyle1 = TextStyle(
    color: textColor1,
    fontSize: 24,
    fontFamily: Assets.poppinsFont,
    fontWeight: FontWeight.w600,
  );

  /// User for Onboarding title and on BackgroundWidget Title
  static const TextStyle textStyle2 = TextStyle(
    color: textColor1,
    fontSize: 12,
    fontFamily: Assets.plusJakartaFont,
    fontWeight: FontWeight.w500,
  );

  /// User for text filed
  static const TextStyle textStyle3 = TextStyle(
    fontFamily: Assets.plusJakartaFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// User For onboarding Subtitle Text
  static const TextStyle onboardingText1 = TextStyle(
    fontFamily: Assets.plusJakartaFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// User for Product Card Texts
  static const TextStyle productCardStyle1 = TextStyle(
    fontFamily: Assets.plusJakartaFont,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  /// User for Service Provider Titles Text
  static const TextStyle serviceProviderStyle1 = TextStyle(
    color: StyleGuide.textColor2,
    fontFamily: Assets.poppinsFont,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  /// User for Service Provider Texts
  static const TextStyle serviceProviderStyle2 = TextStyle(
    color: StyleGuide.textColor2,
    fontFamily: Assets.poppinsFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
