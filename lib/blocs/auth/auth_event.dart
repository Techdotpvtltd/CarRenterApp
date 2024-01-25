import 'package:beasy/models/user_model.dart';

abstract class AuthEvent {}

// AuthEventUninitialize  ========================================
class AuthEventUninitialize extends AuthEvent {}

class AuthEventSplashActionDone extends AuthEvent {}

// AuthEventNeedsToSetProfile
class AuthEventNeedsToSetProfile extends AuthEvent {}

// AuthEventInitialize  ========================================
class AuthEventInitialize extends AuthEvent {}

/// Loading LoginScreen
class AuthEventPerformLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventPerformLogin({required this.email, required this.password});
}

/// Loaded Login Screen
class AuthEventLoadedLogin extends AuthEvent {}

/// Loading GetStarted Screen
class AuthEventLoadedGetStarted extends AuthEvent {}

/// Loaded Signup Screen Event
class AuthEventLoadedSignup extends AuthEvent {}

/// Registering Event
class AuthEventRegistering extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final UserLocation? location;

  AuthEventRegistering(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      this.location});
}

/// Update User Profile
class AuthEventUpdateUserProfile extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? imagePath;
  final UserLocation? location;

  AuthEventUpdateUserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.imagePath,
    this.location,
  });
}

/// Registered Event
class AuthEventRegistered extends AuthEvent {}

///  User Type Events
class AuthEventNeedsToSetUserType extends AuthEvent {}

/// Enable Notification Events
class AuthEventNeedsToEnableNotification extends AuthEvent {}

class AuthEventNeedsSetNotification extends AuthEvent {}

///  LocationAccess Events
class AuthEventNeedsToAllowLocationAccess extends AuthEvent {}

class AuthEventSetLocationAccess extends AuthEvent {}

/// Logout User Event
class AuthEventPerformLogout extends AuthEvent {}

// Apple Login Event
class AuthEventAppleLogin extends AuthEvent {}

// Google Login Event
class AuthEventGoogleLogin extends AuthEvent {}
