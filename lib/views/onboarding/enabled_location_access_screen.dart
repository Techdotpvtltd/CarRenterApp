import 'package:beasy/utilities/shared_preferences.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/navigation_service.dart';
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
              left: 24, right: 24, top: screenHeight * 0.1, bottom: 20),
          child: OnBoardingCenteredWidget(
            iconPath: Assets.locationIcon,
            title: AppStrings.whatIsYourLocation,
            subtitle: AppStrings.locationAccessDescription,
            bottomWidget: Column(
              children: [
                RoundedButton(
                  title: AppStrings.allowLocationAccess,
                  onPressed: () async {
                    final status = await Permission.location.request();
                    if (status.isPermanentlyDenied) {
                      CustomDilaogs().alertBox(
                        title: "Location Permission Required",
                        message:
                            "Please allow location permission in the setting.",
                        negativeTitle: "Close",
                        positiveTitle: "Open Setting",
                        onPositivePressed: () async {
                          await Geolocator.openLocationSettings();
                        },
                        icon: Icons.pin,
                      );
                    }
                    if (status.isGranted) {
                      // ignore: use_build_context_synchronously
                      NavigationService.back(context);
                    }
                  },
                ),
                gapH18,
                TextButton(
                  onPressed: () {
                    LocalPreferences.storeLaterLocationPermission();
                    NavigationService.back(context);
                  },
                  child: const TextButtonChildWidget2(
                    text: AppStrings.enterLocationManully,
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
