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

///Loaded ForgotPassword Screen Event
class AuthEventLoadedForgotPassword extends AuthEvent {}
