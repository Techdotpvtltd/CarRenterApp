import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';

abstract class AuthState {
  final bool isLoading;
  final String loadingText;
  AuthState({this.isLoading = false, this.loadingText = "Please wait."});
}

// AuthStateUnitialize ========================================
class AuthStateUninitialize extends AuthState {
  AuthStateUninitialize({super.isLoading});
}

// AuthStateInitialize  ========================================
class AuthStateInitialize extends AuthState {
  AuthStateInitialize({super.isLoading});
}

// AuthStateStartup  ========================================
class AuthStateStartup extends AuthState {
  AuthStateStartup({super.isLoading});
}

// AuthStateRegistering  ========================================
class AuthStateRegisterring extends AuthState {
  final Exception? exception;

  AuthStateRegisterring({this.exception, super.isLoading});
}

// Auth State Loging with apple
class AuthStateAppleLogging extends AuthState {
  final BeasyException? exception;
  AuthStateAppleLogging({super.isLoading, super.loadingText, this.exception});
}

class AuthStateAppleLoggedIn extends AuthState {
  AuthStateAppleLoggedIn({super.isLoading});
}

// Auth State Loging with google
class AuthStateGoogleLogging extends AuthState {
  final BeasyException? exception;
  AuthStateGoogleLogging({super.isLoading, super.loadingText, this.exception});
}

class AuthStateGoogleLoggedIn extends AuthState {
  AuthStateGoogleLoggedIn({super.isLoading});
}

// AuthStateLoggedIn  ========================================
class AuthStateLoggedIn extends AuthState {
  AuthStateLoggedIn({super.isLoading});
}

/// AuthStateSplashActionDone
class AuthStateSplashActionDone extends AuthState {}

class AuthStateLogging extends AuthState {
  final BeasyException? exception;
  AuthStateLogging({super.isLoading, this.exception, super.loadingText});
}

// Loading Login Screen State  ========================================
class AuthStateLoadedLogin extends AuthState {
  AuthStateLoadedLogin({super.isLoading});
}

/// Loading GetStarted Screen
class AuthStateLoadedGetStarted extends AuthState {
  AuthStateLoadedGetStarted({super.isLoading});
}

// Loaded SignupScreen State  ========================================
class AuthStateLoadedSignup extends AuthState {
  AuthStateLoadedSignup({super.isLoading});
}

// Registered State  ========================================
class AuthStateRegistering extends AuthState {
  final BeasyException? exception;
  AuthStateRegistering({this.exception, super.isLoading, super.loadingText});
}

// User Profile Updating States
class AuthStateUpdatingUserProfile extends AuthState {
  final BeasyException? exception;

  AuthStateUpdatingUserProfile(
      {super.isLoading, super.loadingText, this.exception});
}

class AuthStateUpdatedUserProfile extends AuthState {
  AuthStateUpdatedUserProfile({super.isLoading});
}

// Registered State  ========================================
class AuthStateRegistered extends AuthState {
  AuthStateRegistered({super.isLoading});
}

// UserTypeSet State  ========================================
class AuthStateSetUserType extends AuthState {
  AuthStateSetUserType({super.isLoading});
}

// UserTypeSet State  ========================================
class AuthStateNeedsToSetUserType extends AuthState {
  AuthStateNeedsToSetUserType({super.isLoading});
}

// AuthStateUserTypeSet State  ========================================
class AuthStateUserTypeSet extends AuthState {
  AuthStateUserTypeSet({super.isLoading, super.loadingText});
}

// EnabledNotificationState  ========================================
class AuthStateEnabledNotification extends AuthState {
  AuthStateEnabledNotification({super.isLoading});
}

// NeedToEnableNotificationState  ========================================
class AuthStateNeedsToEnableNotification extends AuthState {
  AuthStateNeedsToEnableNotification({super.isLoading});
}

// AuthStateAllowedLocation  ========================================
class AuthStateAllowedLocation extends AuthState {
  AuthStateAllowedLocation({super.isLoading});
}

// AuthStateNeedToAllowLocation  ========================================
class AuthStateNeedToAllowLocation extends AuthState {
  AuthStateNeedToAllowLocation({super.isLoading});
}
