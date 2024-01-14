import 'package:beasy/bloc/auth/auth_bloc.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/views/onboarding/get_started_screen.dart';
import 'package:beasy/views/onboarding/login_screen.dart';
import 'package:beasy/views/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_event.dart';
import 'observers/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _BeasyApp());
}

class _BeasyApp extends StatelessWidget {
  const _BeasyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      title: 'Beasy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: StyleGuide.primaryColor),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (currentContext) => AuthBloc()),
        ],
        child: const _BeasyPage(),
      ),
    );
  }
}

class _BeasyPage extends StatelessWidget {
  const _BeasyPage();

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthStateStartup) {
          return const SplashScreen();
        }

        if (state is AuthStateLoadedGetStarted) {
          return const GetStartedScreen();
        }
        if (state is AuthStateLoadedLogin) {
          return const LoginScreen();
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      buildWhen: (previous, current) {
        return false;
      },
    );
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
