import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/onboarding_centered_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/views/onboarding/verify_email_screen.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: OnBoardingCenteredWidget(
              iconPath: Assets.lockIcon,
              title: AppStrings.forgotPassword,
              subtitle: AppStrings.pleaseEnterEmailForForgotPassword,
              centeredWidget: const CustomTitleTextField(
                fieldText: AppStrings.email,
                hintText: AppStrings.enterYourEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              bottomWidget: RoundedButton(
                  title: AppStrings.next,
                  onPressed: () {
                    NavigationService.off(context, const VerifyEmailScreen());
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
