import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/onboarding_text_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BackgroundWidget(
      innerWidget: Padding(
        padding: EdgeInsets.symmetric(vertical: 43, horizontal: 33),
        child: OnboardingTextWidget(
          title: "Hi, Welcome Back! 👋",
          subTitle: "Please fill up your information to continue",
        ),
      ),
      outerWidget: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleTextFiled(),
            ],
          ),
        ),
      ),
    );
  }
}
