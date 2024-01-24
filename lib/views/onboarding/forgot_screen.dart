import 'package:beasy/repositories/repos/auth_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/utils.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/loaders.dart';
import 'package:beasy/utilities/widgets/onboarding_centered_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/views/onboarding/verify_email_screen.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  String? _errorMessage;
  final TextEditingController _emailController = TextEditingController();

  void _sendEmail() async {
    final String email = _emailController.text;
    if (email == "") {
      setState(() {
        _errorMessage = "Please Enter email";
      });

      return;
    }

    if (!Util.isValidEmail(email: email)) {
      setState(() {
        _errorMessage = "Invalid Email.";
      });
      return;
    }

    Loader().show();
    await AuthRepo().sendForgotPasswordEmail(atMail: _emailController.text);
    Loader().hide();
    // ignore: use_build_context_synchronously
    NavigationService.off(context, const VerifyEmailScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: OnBoardingCenteredWidget(
            iconPath: Assets.lockIcon,
            title: AppStrings.forgotPassword,
            subtitle: AppStrings.pleaseEnterEmailForForgotPassword,
            centeredWidget: CustomTitleTextField(
              controller: _emailController,
              errorText: _errorMessage,
              fieldText: AppStrings.email,
              hintText: AppStrings.enterYourEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            bottomWidget: RoundedButton(
              title: AppStrings.next,
              onPressed: () {
                _sendEmail();
              },
            ),
          ),
        ),
      ),
    );
  }
}
