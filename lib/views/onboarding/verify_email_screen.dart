import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/onboarding_centered_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/constants.dart';
import '../../utilities/widgets/custom_app_bar.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: OnBoardingCenteredWidget(
            iconPath: Assets.emailSent,
            title: AppStrings.emailVerification,
            subtitle: AppStrings.weWillSendYouALinkOnYourEmail,
            bottomWidget: Column(
              children: [
                RoundedButton(title: AppStrings.openEmailApp, onPressed: () {}),
                gapH24,
                TextButton(
                  onPressed: () {
                    NavigationService.back(context);
                  },
                  child: const TextButtonChildWidget(
                    text: AppStrings.skipIWillConfirmLater,
                    textColor: Color(0xFF848484),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
