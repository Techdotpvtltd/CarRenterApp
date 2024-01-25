// ignore_for_file: use_build_context_synchronously

import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';
import 'package:beasy/repositories/repos/auth_repo.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/shared_preferences.dart';
import 'package:beasy/views/onboarding/enable_notification_screen.dart';
import 'package:beasy/views/onboarding/enabled_location_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateToNextScreen(AuthBloc bloc) async {
    try {
      final currentUser = AuthRepo().currentUser();
      if (currentUser != null) {
        await UserRepo().fetch();

        // Check for permissions
        if (!await Permission.notification.isGranted &&
            await LocalPreferences.getLaterNotificationPermission() == false) {
          await NavigationService.go(context, const EnableNotificationScreen());
        }

        if (!await Permission.location.isGranted &&
            await LocalPreferences.getLaterNotificationPermission() == false) {
          await NavigationService.go(
              context, const EnableLocationAccessScreen());
        }

        bloc.add(AuthEventSplashActionDone());

        return;
      }

      bloc.add(AuthEventLoadedGetStarted());
    } on BeasyException catch (_) {
      bloc.add(AuthEventLoadedGetStarted());
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _navigateToNextScreen(context.read<AuthBloc>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(Assets.titleLogo),
      ),
    );
  }
}
