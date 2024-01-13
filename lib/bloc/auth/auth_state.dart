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
