import 'package:beasy/bloc/auth/auth_bloc.dart';
import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) {}),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              Assets.splashBackground,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 73, left: 23, right: 23, bottom: 48),
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
                        context.read<AuthBloc>().add(AuthEventLoadedLogin());
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
      ),
    );
  }
}
