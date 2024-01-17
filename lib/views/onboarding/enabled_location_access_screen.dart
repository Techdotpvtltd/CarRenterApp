import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/widgets/onboarding_centered_widget.dart';
import '../../utilities/widgets/rounded_button.dart';
import '../../utilities/widgets/text_button_child_widget.dart';

class EnableLocationAccessScreen extends StatelessWidget {
  const EnableLocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 24, right: 24, top: mediaQueryHeight * 0.1, bottom: 20),
          child: OnBoardingCenteredWidget(
            iconPath: Assets.locationIcon,
            title: AppStrings.whatIsYourLocation,
            subtitle: AppStrings.locationAccessDescription,
            bottomWidget: Column(
              children: [
                RoundedButton(
                    title: AppStrings.allowLocationAccess,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthEventRegistered());
                    }),
                gapH18,
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventRegistered());
                  },
                  child: const TextButtonChildWidget2(
                      text: AppStrings.enterLocationManully),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
