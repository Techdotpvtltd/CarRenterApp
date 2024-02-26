import 'package:beasy/app_manager/app_bloc_manager.dart';
import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/blocs/rental/rental_product_bloc.dart';
import 'package:beasy/blocs/service_provider/sp_bloc.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/screens/menu/drawer_screen.dart';
import 'package:beasy/screens/onboarding/enable_notification_screen.dart';
import 'package:beasy/screens/onboarding/enabled_location_access_screen.dart';
import 'package:beasy/screens/onboarding/get_started_screen.dart';
import 'package:beasy/screens/onboarding/login_screen.dart';
import 'package:beasy/screens/onboarding/sign_up_screen.dart';
import 'package:beasy/screens/onboarding/splash_screen.dart';
import 'package:beasy/screens/onboarding/user_type_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_manager/app_bloc_observer.dart';
import 'app_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();
  //  1 - Ensure firebase app is initialized if starting from background/terminated state
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AppBlocManager().authBloc),
        BlocProvider<RentalProductBloc>(
            create: (context) => AppBlocManager().rentalBloc),
        BlocProvider<SPBloc>(create: (context) => AppBlocManager().spBloc),
        BlocProvider(
          create: (context) => DrawerCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navKey,
        title: 'Beasy',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: StyleGuide.primaryColor).copyWith(
                  // background: Colors.white,
                  ),
        ),
        home: const _BeasyPage(),
      ),
    );
  }
}

class _BeasyPage extends StatelessWidget {
  const _BeasyPage();

  @override
  Widget build(BuildContext context) {
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

        if (state is AuthStateLoadedSignup) {
          return const SignUpScreen();
        }
        if (state is AuthStateNeedsToSetUserType) {
          return const UserTypeScreen();
        }

        if (state is AuthStateNeedsToEnableNotification) {
          return const EnableNotificationScreen();
        }

        if (state is AuthStateNeedToAllowLocation) {
          return const EnableLocationAccessScreen();
        }

        if (state is AuthStateSplashActionDone ||
            state is AuthStateAppleLoggedIn ||
            state is AuthStateLoggedIn) {
          return const HomeDrawer();
        }

        return const SplashScreen();
      },
      buildWhen: (previous, current) {
        /// If these states are emitted then rebuild the widget, otherwise not.
        return current is AuthStateStartup ||
            current is AuthStateLoadedGetStarted ||
            current is AuthStateLoadedLogin ||
            current is AuthStateLoadedSignup ||
            current is AuthStateNeedsToSetUserType ||
            current is AuthStateNeedsToEnableNotification ||
            current is AuthStateNeedToAllowLocation ||
            current is AuthStateLoggedIn ||
            current is AuthStateSplashActionDone ||
            current is AuthStateInitialize ||
            current is AuthStateAppleLoggedIn;
      },
    );
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
