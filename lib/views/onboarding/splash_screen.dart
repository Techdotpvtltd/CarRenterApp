import 'package:beasy/app_manager/app_manager.dart';
import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/repositories/repos/auth_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateToNextScreen(AuthBloc bloc) async {
    final currentUser = AuthRepo().currentUser();
    if (currentUser != null) {
      await AuthRepo().fetchUser();
      if (AppManager().user == null) {
        bloc.add(AuthEventNeedsToSetProfile());
        return;
      }

      if (AppManager().user?.userType == null) {
        bloc.add(AuthEventNeedsToSetUserType());
        return;
      }
      bloc.add(AuthEventSplashActionDone());

      return;
    }

    bloc.add(AuthEventLoadedGetStarted());
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
