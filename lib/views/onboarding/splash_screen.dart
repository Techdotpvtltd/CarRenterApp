import 'package:beasy/bloc/auth/auth_bloc.dart';
import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/views/onboarding/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateToNextScreen(AuthBloc bloc) {
    bloc.add(AuthEventLoadedGetStarted());
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen(context.read<AuthBloc>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: Center(
          child: SvgPicture.asset(Assets.titleLogo),
        ),
      ),
    );
  }
}
