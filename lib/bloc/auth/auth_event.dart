abstract class AuthEvent {}

// AuthEventUninitialize  ========================================
class AuthEventUninitialize extends AuthEvent {}

// AuthEventInitialize  ========================================
class AuthEventInitialize extends AuthEvent {}

/// Loading LoginScreen
class AuthEventLoadedLogin extends AuthEvent {}

/// Loading GetStarted Screen
class AuthEventLoadedGetStarted extends AuthEvent {}

/// Loaded Signup Screen Event
class AuthEventLoadedSignup extends AuthEvent {}

/// Registered Event
class AuthEventRegistered extends AuthEvent {}

///  User Type Events
class AuthEventNeedsToSetUserType extends AuthEvent {}

class AuthEventSetUserType extends AuthEvent {}

/// Enable Notification Events
class AuthEventNeedsToEnableNotification extends AuthEvent {}

class AuthEventNeedsSetNotification extends AuthEvent {}

///  LocationAccess Events
class AuthEventNeedsToAllowLocationAccess extends AuthEvent {}

class AuthEventSetLocationAccess extends AuthEvent {}
