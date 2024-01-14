import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';

class StyleGuide {
  // Colors  ========================================
  /// Use For BoundedButtons, Navigation Background, pop_up/dialogs,
  static const Color primaryColor = Color(0xFF3474FF);

  /// Use For Screen Background,
  static const Color backgroundColor = Colors.white;

  /// User For Button Title, Black or other background's widget
  static const Color textColor1 = Colors.white;

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
}
