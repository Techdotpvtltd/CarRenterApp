// ignore_for_file: use_build_context_synchronously

import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/extensions/shared_preferences.dart';
import 'package:beasy/utilities/widgets/onboarding_centered_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
            iconPath: Assets.bigBellIcon,
            title: AppStrings.enableNotificationAccess,
            subtitle: AppStrings.noticationAccessDescription,
            bottomWidget: Column(
              children: [
                RoundedButton(
                    title: AppStrings.allowNotification,
                    onPressed: () async {
                      await Permission.notification.request();
                      NavigationService.back(context);
                    }),
                gapH18,
                TextButton(
                  onPressed: () {
                    LocalPreferences.storeLaterNotificationPermission();
                    NavigationService.back(context);
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
