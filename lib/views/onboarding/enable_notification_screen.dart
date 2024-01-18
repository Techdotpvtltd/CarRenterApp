import 'package:beasy/bloc/auth/auth_bloc.dart';
import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/onboarding_centered_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnableNotificationScreen extends StatelessWidget {
  const EnableNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 24, right: 24, top: screenHeight * 0.1, bottom: 20),
          child: OnBoardingCenteredWidget(
            iconPath: Assets.bellIcon,
            title: AppStrings.enableNotificationAccess,
            subtitle: AppStrings.noticationAccessDescription,
            bottomWidget: Column(
              children: [
                RoundedButton(
                    title: AppStrings.allowNotification,
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthEventNeedsToAllowLocationAccess());
                    }),
                gapH18,
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(AuthEventNeedsToAllowLocationAccess());
                  },
                  child:
                      const TextButtonChildWidget2(text: AppStrings.maybeLater),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
