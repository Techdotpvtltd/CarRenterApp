abstract class AuthState {
  final bool isLoading;
  final String loadingText;
  AuthState({required this.isLoading, this.loadingText = ""});
}

// AuthStateUnitialize ========================================
class AuthStateUninitialize extends AuthState {
  AuthStateUninitialize({required super.isLoading});
}

// AuthStateInitialize  ========================================
class AuthStateInitialize extends AuthState {
  AuthStateInitialize({required super.isLoading});
}

// AuthStateStartup  ========================================
class AuthStateStartup extends AuthState {
  AuthStateStartup({required super.isLoading});
}

// AuthStateRegistering  ========================================
class AuthStateRegisterring extends AuthState {
  final Exception? exception;

  AuthStateRegisterring({this.exception, required super.isLoading});
}

// AuthStateLoggedIn  ========================================
class AuthStateLoggedIn extends AuthState {
  AuthStateLoggedIn({required super.isLoading});
}

// Loading Login Screen State  ========================================
class AuthStateLoadedLogin extends AuthState {
  AuthStateLoadedLogin({required super.isLoading});
}

/// Loading GetStarted Screen
class AuthStateLoadedGetStarted extends AuthState {
  AuthStateLoadedGetStarted({required super.isLoading});
}

// Loaded SignupScreen State  ========================================
class AuthStateLoadedSignup extends AuthState {
  AuthStateLoadedSignup({required super.isLoading});
}

// Registered State  ========================================
class AuthStateRegistered extends AuthState {
  AuthStateRegistered({required super.isLoading});
}

// UserTypeSet State  ========================================
class AuthStateSetUserType extends AuthState {
  AuthStateSetUserType({required super.isLoading});
}

// UserTypeSet State  ========================================
class AuthStateNeedsToSetUserType extends AuthState {
  AuthStateNeedsToSetUserType({required super.isLoading});
}

// EnabledNotificationState  ========================================
class AuthStateEnabledNotification extends AuthState {
  AuthStateEnabledNotification({required super.isLoading});
}

// NeedToEnableNotificationState  ========================================
class AuthStateNeedsToEnableNotification extends AuthState {
  AuthStateNeedsToEnableNotification({required super.isLoading});
}

// AuthStateAllowedLocation  ========================================
class AuthStateAllowedLocation extends AuthState {
  AuthStateAllowedLocation({required super.isLoading});
}

// AuthStateNeedToAllowLocation  ========================================
class AuthStateNeedToAllowLocation extends AuthState {
  AuthStateNeedToAllowLocation({required super.isLoading});
}
