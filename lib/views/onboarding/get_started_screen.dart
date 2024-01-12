import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/views/onboarding/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.splashBackground,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 73, left: 23, right: 23, bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.whiteLogo),
                gapH18,
                const Text(
                  AppStrings.getStartedTitle,
                  style: TextStyle(
                    fontSize: 38,
                    color: StyleGuide.textColor1,
                    fontFamily: Assets.poppinsFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: RoundedButton(
                    onPressed: () {
                      NavigationService.go(context, const LoginScreen());
                    },
                    title: AppStrings.letsGo,
                    width: 165,
                    height: 43,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
