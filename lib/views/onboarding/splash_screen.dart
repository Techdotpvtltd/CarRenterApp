import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
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
      body: Center(
        child: SvgPicture.asset(Assets.titleLogo),
      ),
    );
  }
}
