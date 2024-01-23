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
  final String location;

  AuthEventRegistering(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.location});
}

/// Registered Event
class AuthEventRegistered extends AuthEvent {}

///  User Type Events
class AuthEventNeedsToSetUserType extends AuthEvent {}

/// User Type Event
class AuthEventUserTypeSet extends AuthEvent {
  final int selectedIndex;

  AuthEventUserTypeSet({required this.selectedIndex});
}

/// Enable Notification Events
class AuthEventNeedsToEnableNotification extends AuthEvent {}

class AuthEventNeedsSetNotification extends AuthEvent {}

///  LocationAccess Events
class AuthEventNeedsToAllowLocationAccess extends AuthEvent {}

class AuthEventSetLocationAccess extends AuthEvent {}

/// Logout User Event
class AuthEventPerformLogout extends AuthEvent {}
